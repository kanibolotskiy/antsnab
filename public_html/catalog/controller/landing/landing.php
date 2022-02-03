<?php
class ControllerLandingLanding extends Controller {
    public function sendForm(){
        $data=$this->request->post;
        
    }

	public function changeProduct(){
        $this->load->model('landing/landing');
        $this->load->model('tool/image');
        $product_id=$this->request->post['product_id'];
        $landing_id=$this->request->post['landing_id'];

        $alias="lp-".$this->model_landing_landing->getProductAlias($product_id);
        $landingAlias=$this->model_landing_landing->getLandingAlias($landing_id);

        $product_data=$this->model_landing_landing->getProductInfo($product_id);
        $data_lp=json_decode(str_replace(array("\r\n", "\n", "\r"),'',$product_data['data_lp']),JSON_UNESCAPED_UNICODE);
        
        if($data_lp['product_lp_name']){
            $product_data['name'] =$data_lp['product_lp_name'];
        }
        //print_r($product_data);
        switch ($data_lp['product_lp_price']){
            case 0: //Не показывать цену
                $product_data['price_str']="";
                break;
            case 1: //Розничная
                $product_data['price_str']="от ".number_format($product_data['price'], 0, ',', ' ');
                break;
            case 2: //Оптовая
                $product_data['price_str']="от ".number_format($product_data['price_wholesale'], 0, ',', ' ').' ₽';
                break;
            case 3: //С1
                $product_data['price_str']="от ".number_format($product_data['price_c1'], 0, ',', ' ').' ₽';
                break;
            case 4: //С2
                $product_data['price_str']="от ".number_format($product_data['price_c2'], 0, ',', ' ').' ₽';
                break;
        }
        $data['alias']=$landingAlias."/".$alias."/";
        $data['thumb'] = $this->model_tool_image->resize($product_data['image'], 560, 560);
        $data['image']=$product_data['image'];
        $data['name']=$product_data['name'];
        if(isset($product_data['price_str'])){
            $data['price']=$product_data['price_str'];
        }else{
            $data['price']='';
        }
        return $this->response->setOutput(json_encode($data));
    }
	public function index() {
        $this->load->model('landing/landing');
        $this->load->model('module/referrer');
        $this->load->model('catalog/product');
        $this->load->model('tool/image');

        if (isset($this->request->get['landing_id'])) {
			$landing_id = (int)$this->request->get['landing_id'];
		} else {
			$landing_id = 0;
		}

        $data=$this->model_landing_landing->getLandingInfo($landing_id);
        
		$contact_data_referrer=$this->model_module_referrer->getContactsReferrer();
        $contact_data_referrer['logotext']=$data['logotext'];

        $contact_data_referrer['meta_title']=$data['meta_title'];
        $contact_data_referrer['meta_description']=$data['meta_description'];
 
        $data['head']=$this->load->controller('landing/head',$contact_data_referrer);
        $data['header']=$this->load->controller('landing/header',$contact_data_referrer);
        $data['footer']=$this->load->controller('landing/footer',$contact_data_referrer);
        
        $products=[];
        $video_arr=[];
        foreach($data['product_list'] as $key=>$itm){
            if($itm){
                $products_arr[$key]=explode(",",$itm);
                foreach($products_arr[$key] as $product_id){
                    if($product_id){
                        $product_data=$this->model_landing_landing->getProductInfo($product_id);
                        $data_lp=json_decode(str_replace(array("\r\n", "\n", "\r"),'',$product_data['data_lp']),JSON_UNESCAPED_UNICODE);
                        
                        if($data_lp['product_lp_name']){
                            $product_data['name'] =$data_lp['product_lp_name'];
                        }
                        if($data_lp['product_lp_lsi']){
                            $product_data['description_mini'] = $data_lp['product_lp_lsi'];
                        }

                        //print_r($product_data);
                        switch ($data_lp['product_lp_price']){
                            case 0: //Не показывать цену
                                $product_data['price_str']="";
                                break;
                            case 1: //Розничная
                                $product_data['price_str']="от ".number_format($product_data['price'], 0, ',', ' ').' ₽';
                                break;
                            case 2: //Оптовая
                                $product_data['price_str']="от ".number_format($product_data['price_wholesale'], 0, ',', ' ').' ₽';
                                break;
                            case 3: //С1
                                $product_data['price_str']="от ".number_format($product_data['price_c1'], 0, ',', ' ').' ₽';
                                break;
                            case 4: //С2
                                $product_data['price_str']="от ".number_format($product_data['price_c2'], 0, ',', ' ').' ₽';
                                break;
                            case 5: //С3
                                $product_data['price_str']="от ".number_format($product_data['price_c3'], 0, ',', ' ').' ₽';
                            break;
                        }
                        
                        //print_r($data_lp['product_lp_video']);
                        if(isset($data_lp['product_lp_video'])){
                            if($data_lp['product_lp_video']){
                                foreach($data_lp['product_lp_video'] as $video_item){
                                    $video_arr[]=Array(
                                        'video'=>$video_item['url'],
                                        'image'=>$this->model_tool_image->resize('../image/'.$video_item['image'], 580, 325),
                                        'video_caption'=>$video_item['text']
                                    );
                                }
                            }
                        }
                        
                        $products_links=$this->model_catalog_product->getProductLinks($product_id);
                        $product_data['products_links']=[];

                        $flags=[];
                        $color_product=[];
                        foreach($products_links as $key1=>$products_link){
                            unset($data_temp);
                            foreach($products_links[$key1] as $itm1){
                                if($itm1['product_id']==$product_id){
                                    $flags[$key1]=true;
                                    if($key1==1){
                                        $color_product=Array("name"=>$itm1['name'],"code"=>$itm1['code']);
                                    }
                                }
                                $data_temp[$key1][]=Array(
                                    "name"=>$itm1['name'],
                                    "code"=>$itm1['code'],
                                    "product_id"=>$itm1['product_id'],
                                    //"link"=>$this->url->link('product/product', 'product_id=' . $itm1['product_id']),
                                );
                            }
                        }
                        foreach($flags as $key1=>$flag){
                            $product_data['products_links'][$key1]=$data_temp[$key1];
                        }
            
                        $alias="lp-".$this->model_landing_landing->getProductAlias($product_id);
                        $landingAlias=$this->model_landing_landing->getLandingAlias($landing_id);

                        $product_data['color_product']=$color_product;
                        $product_data['alias'] = $landingAlias."/".$alias."/";
                        

                        $product_data['thumb'] = $this->model_tool_image->resize($product_data['image'], 560, 560);
                        $product_data['image'] = $product_data['image'];
                        $products[$key][]=$product_data;
                    }
                    
                }
            }
        }     
        $data['landing_id']=$landing_id;
        $data['video']=$video_arr;
        $data['products']=$products;
        
        $this->response->setOutput($this->load->view('landing/landing.tpl', $data));
        
    }
}