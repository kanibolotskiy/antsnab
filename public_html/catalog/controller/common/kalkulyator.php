<?php
/*
use Phospr\Fraction;

use WS\Override\Gateway\ProdProperties; 
use WS\Patch\Helper\QueryHelper;
*/
use WS\Override\Gateway\ProdUnits\ProdUnitStrings;
use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitsCalc;
use WS\Patch\Helper\ProductListHelper;

class ControllerCommonKalkulyator extends Controller {
    private function declination($number, $titles) {
        $cases = array(2, 0, 1, 1, 1, 2);
        return $number." ".$titles[($number%100>4 && $number%100<20) ? 2 : $cases[min($number%10, 5)]];   
    }
    public function calcData() {
        $this->load->model('calc/calc');

        $calculator_id=$_POST['calculator_id'];
        if($calculator_id){
            
            
            $products=$this->model_calc_calc->getProductsByCalc($calculator_id);
            $productsHelper = new ProductListHelper($this->registry);
            $produnitsGateway = new ProdUnits($this->registry);
            $produnitsCalcGateway = new ProdUnitsCalc($this->registry);
              
            $filter_data=[
                "product_ids"=>implode(",",$products),
                "sort"=>"ids",
                "order"=>"ids"
            ];
            $data_products=$productsHelper->getProducts($filter_data);

            $products_list="";
            
            $product_ids=[];
            foreach($data_products as $key=>$product){
                
                if($calculator_id==1 or $calculator_id==2){
                    $area=$_POST['area'];
                    $total_consumption=$product['consumption']*$area;
                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                    $weight=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $weight=$unit['weight'];
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                        }
                    }
                    $rashod=ceil($total_consumption/$weight);
                }
                if($calculator_id==3){
                    $area1=$_POST['area1'];
                    $area2=$_POST['area2'];
                    $area3=$_POST['area3'];
                    $total_volume=$product['calc_data1']*$area1*$area2*$area3;
                    $total_volume=ceil($total_volume*100)/100;

                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                    $volume=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $volume=$unit['calcKoef'];
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                        }
                    }
                    $rashod=ceil($total_volume/$volume);                    
                }

                if($calculator_id==4){
                    $area1=$_POST['area1'];
                    $area2=$_POST['area2'];
                    $area3=$_POST['area3'];
                    $total_volume=$product['calc_data2']*$product['calc_data3']*$area1*$area2*$area3/10;
                    $total_volume=ceil($total_volume*100)/100;                  
                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                    $weight=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $weight=$unit['weight'];
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                        }
                    }
                    $rashod=ceil($total_volume/$weight);
                }

                if($calculator_id==5){
                    $area1=$_POST['area1'];
                    $area2=$_POST['area2'];
                    $area3=$_POST['area3'];
                    $total_volume=$area1*$area2*$area3/10/$product['calc_data4'];

                    $total_volume=ceil($total_volume*100)/100;                  
                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                    $weight=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $weight=$unit['weight'];
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                        }
                    }
                    $rashod=ceil($total_volume/$weight);
                }

                if($calculator_id==6){
                    $area=$_POST['area'];
                    
                    //$total_volume=$area1*$area2*$area3/10/$product['calc_data3'];
                    
                    $total_value=ceil($area*$product['calc_data3']);
                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);                    
                    $calcKoef=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                            $calcKoef=$unit['calcKoef'];
                        }
                    }
                    /*
                    $total_volume=ceil($total_volume*100)/100;                  
                    $prodUnits = $produnitsGateway->getUnitsByProduct($product['product_id']);
                    $weight=1;
                    foreach($prodUnits as $unit){
                        if($unit['isPackageBase']){
                            $weight=$unit['weight'];
                            $plurals=[$unit['name'],$unit['name_package_dimension'],$unit['name_plural']];
                        }
                    }
                    */
                    $rashod=ceil($total_value/$calcKoef);
                }

                $dt['cnt']=$rashod;
                $dt['rashod']=$this->declination($rashod,$plurals);
                $dt['class_hide']=$key?'_hidden':'';
                $dt['p']=$product;
                $product_ids[]=$product['product_id'];
                $products_list.=$this->load->view('partial/calc_product', $dt);
            }
            $append='';
            if(count($data_products)>1){
                $append='<div class="calc_show_more">Показать еще '.$this->declination((count($data_products)-1),['вариант','варианта','вариантов']).'</div>';
            }
            $data['products']=$products_list.$append;

            $products_analog_list='';
            $append='';
            $products_analog=$this->model_calc_calc->getProductsAnalog($product_ids);

            if($products_analog){
                $filter_data=[
                    "product_ids"=>implode(",",$products_analog),
                    "sort"=>"ids",
                    "order"=>"ids"
                ];
                $data_products_analog=$productsHelper->getProducts($filter_data);

                foreach($data_products_analog as $key=>$product){
                    $dt['p']=$product;
                    $dt['cnt']=0;
                    $dt['class_hide']=$key?'_hidden':'';
                    $products_analog_list.=$this->load->view('partial/calc_product', $dt);
                }

                if(count($products_analog)>1){
                    $append='<div class="calc_show_more">Показать еще '.$this->declination((count($products_analog)-1),['вариант','варианта','вариантов']).'</div>';
                }
            }
            $data['products_analog']=$products_analog_list.$append;

            //print_r($data_products);
            /**/
            echo json_encode($data,true);
        }
        
    }
	public function index() {
        $ttl="Калькулятор расхода монтажной пены и герметика для швов – «Ант-Снаб»";
        $this->load->model('catalog/information');
        $this->load->model('catalog/product');
        $this->load->model('catalog/category');
        $this->load->model('tool/image');
        $this->load->model('extension/module/category');
        $data=[];

        
        $this->document->setTitle($ttl);
        $this->document->setDescription("Онлайн расчет расхода битумной мастики, рулонной кровли, герметика и монтажной пены для швов в калькуляторе от компании «Ант-Снаб»");

        /**Хлебные крошки */
        $data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/home'),
			'text' => $this->language->get('text_home')
		);
		$data['breadcrumbs'][] = array(
			'href' => $this->url->link('common/compare'),
			'text' => $ttl
        );

        $data['footer'] = $this->load->controller('common/footer');
        $data['header'] = $this->load->controller('common/header');

        

        echo $this->load->view('common/calc', $data);
        //return $this->load->view('common/favorite', $data);
        
	}

}
