<?php
class ControllerLandingLanding extends Controller {
    private function sendTelegram($text){
        $tg_user = '-639024206'; // id пользователя, которому отправиться сообщения
        $bot_token = '5289462172:AAGuPiPhyHnrkuiZa3JDaqEGinuqbQMxoNc'; // токен бота
        
        
        // параметры, которые отправятся в api телеграмм
        $params = array(
            'chat_id' => $tg_user, // id получателя сообщения
            'text' => $text, // текст сообщения
            'parse_mode' => 'HTML', // режим отображения сообщения, не обязательный параметр
        );
        
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, 'https://api.telegram.org/bot' . $bot_token . '/sendMessage'); // адрес api телеграмм
        curl_setopt($curl, CURLOPT_POST, true); // отправка данных методом POST
        curl_setopt($curl, CURLOPT_TIMEOUT, 10); // максимальное время выполнения запроса
        curl_setopt($curl, CURLOPT_POSTFIELDS, $params); // параметры запроса
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($curl, CURLOPT_FOLLOWLOCATION, true);

        $result = curl_exec($curl); // запрос к api
        curl_close($curl);
    }
    public function sendForm(){
        $this->load->model('landing/landing');
        $this->load->model('module/referrer');
        
        $data=$this->request->post;
        $out=[];
        if(!$data['workemail']){
            $this->model_landing_landing->addLandingHistory($data);
            $landing_id=$data['landing_id'];
            $landingData=$this->model_landing_landing->getLandingInfo($landing_id);
            
            $mailto=$landingData['mail1'];
            $out['file']='';


            if($landingData['landprice']){
                $type_price=$landingData['landprice'];
            }else{
                //print_r($landingData['product_list']);
                $pr_temp=explode(",",$landingData['product_list'][0]);
                

                //echo "pro_id=".;
                $product_data=$this->model_landing_landing->getProductInfo($pr_temp[0]);
                //$data_lp=json_encode($productData,TRUE);
                $data_lp=json_decode(str_replace(array("\r\n", "\n", "\r"),'',$product_data['data_lp']),JSON_UNESCAPED_UNICODE);
               //print_r($data_lp);
                //$dataProduct=$landingData['']

                $type_price=$data_lp['product_lp_price'];
            }
            
            switch ($type_price){
                case 0: //Не показывать цену
                    $price_str="";
                    break;
                case 1: //Розничная
                    $price_str="Розничная";
                    break;
                case 2: //Оптовая
                    $price_str="Оптовая";                    
                    break;
                case 3: //С1
                    $price_str="Цена C1";
                    break;
                case 4: //С2
                    $price_str="Цена C2";
                    break;
                case 5: //С3
                    $price_str="Цена C3";
                    break;                    
            }
            
            switch ($data['tp']){
                case 1: //Простая форма
                    
                    //$out['test']=$landingData['form_file'];
                    if($landingData['form_file']){
                        $caption_telega = "Заполнена простая форма со скачиванием КП \n";
                        $subject="Landing page / простая форма с КП";
                        $data['caption']="Заполнена простая форма с КП";
                        $data['text']="Клиент заполнил простую форму на нашем сайте и получил Коммерческое предложение с ценами '".$price_str."'.<br/>
                        Живенько-быренько принимаем обращение, создаем интерес и набираем его номер.";
                        if(isset($data['gf'])){
                            if($data['gf']){
                                $out['file']=$landingData['form_file'];
                                $data['file_kp']=$landingData['form_file'];
                            }
                        }
                    }else{
                        $data['caption']="Заполнена простая форма";
                        $subject="Landing page / простая форма";
                        
                        $data['text']="Клиент заполнил простую форму на нашем сайте и ждет вашего звонка.<br/>
                        Живенько-быренько принимаем обращение, создаем интерес и набираем его номер.";

                        $caption_telega = "Заполнена простая форма без КП \n";
                        /*
                        Лендинг: <b>*название лендинга*</b>\n
                        Телефон: <b>*номер телефона*</b>\n
                        \n";
                        /*
                        utm source: *метка*
                        utm medium: *метка*
                        utm campaign: *метка*
                        utm term: *метка*
                        utm content: *метка*";
                        */
                    }

                break;

                case 2: //Полная форма
                    $subject="Landing page / сложная форма";
                    $caption_telega="Заполнена сложная форма \n";
                    $data['caption']="Заполнена сложная форма";
                    $data['text']="Клиент заполнил сложную форму на нашем сайте.<br/>
                    Живенько-быренько принимаем обращение, создаем интерес, тщательно изучаем клиента (по сайту или названию компании) и только потом набираем его номер.";
                break;

                case 3: //Форма во всплывающем окне
                    $subject="Landing page / заявка";
                    $caption_telega="Получена заявка \n";

                    $data['caption']="Получена заявка";
                    $data['text']="Клиент заинтересовался товаром.<br/>
                    Живенько-быренько принимаем обращение, создаем интерес и набираем его номер.";
                break;
                default:
                    $subject="";
                    $caption_telega="";
                    $data['caption']="";
                    $data['text']="";
                break;
            }
            $data['caption_telega']=$caption_telega;
            if(!$mailto){
                $mailto="info@ant-snab.ru1";
                //$mailto="kanibolotskiy@gmail.com";
            }
            /**UTM метки */
            $this->load->model('module/referrer');
            $contact_data_referrer=$this->model_module_referrer->getContactsReferrer();

            if(isset($contact_data_referrer['utm_source'])){
                $data['utm_source']=$contact_data_referrer['utm_source'];
            }else{
                $data['utm_source']="";
            }
            if(isset($contact_data_referrer['utm_medium'])){
                $data['utm_medium']=$contact_data_referrer['utm_medium'];
            }else{
                $data['utm_medium']="";
            }
            if(isset($contact_data_referrer['utm_campaign'])){
                $data['utm_campaign']=$contact_data_referrer['utm_campaign'];
            }else{
                $data['utm_campaign']="";
            }
            if(isset($contact_data_referrer['utm_content'])){
                $data['utm_content']=$contact_data_referrer['utm_content'];
            }else{
                $data['utm_content']="";
            }
            if(isset($contact_data_referrer['utm_term'])){
                $data['utm_term']=$contact_data_referrer['utm_term'];
            }else{
                $data['utm_term']="";
            }
            
            $text=$this->load->view('landing/mailtelegram', $data);
            $this->sendTelegram($text);

            //$subject=$data['subject'];
            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
            
            $mail->setSubject($subject);
            $mail->setHtml($this->load->view('landing/mailorder1', $data));
            $mail->setTo($mailto);
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender("ООО «ТК Ант-Снаб»");
            $mail->send();
            
        }
        $this->response->setOutput(json_encode($out,TRUE));
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
        
        $data_landing=$this->model_landing_landing->getLandingInfo($landing_id);

        if($data_lp['product_lp_name']){
            $product_data['name'] =$data_lp['product_lp_name'];
        }
        if($data_landing['landprice']){
            $type_price=$data_landing['landprice'];
        }else{
            $type_price=$data_lp['product_lp_price'];
        }

        switch ($type_price){
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
            case 4: //С3
                $product_data['price_str']="от ".number_format($product_data['price_c3'], 0, ',', ' ').' ₽';
                break;
        }
        $data['alias']=$landingAlias."/".$alias."/";
        $data['thumb'] = $this->model_tool_image->resize($product_data['image'], 560, 560);
        $data['image']=$product_data['image'];
        $data['name']=$product_data['name'];
        $data['sku']=$product_data['sku'];

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
        
        
        //$landing_enabled=true;
        if($data['status']){
            $contact_data_referrer=$this->model_module_referrer->getContactsReferrer();
            $contact_data_referrer['logotext']=$data['logotext'];

            $contact_data_referrer['meta_title']=$data['meta_title'];
            $contact_data_referrer['meta_description']=$data['meta_description'];
            $contact_data_referrer['landing_id']=$landing_id;
            $contact_data_referrer['title']=$data['title'];
            $contact_data_referrer['mailthanks']=$data['mailthanks'];
            $contact_data_referrer['mailthanks_full']=$data['mailthanks_full'];
            $contact_data_referrer['mailthanks_modal']=$data['mailthanks_modal'];
            $contact_data_referrer['type']='land';
            
            $landingAlias=$this->model_landing_landing->getLandingAlias($landing_id);
            $contact_data_referrer['url']=$landingAlias;
            $contact_data_referrer['image']=$data['block1_image'];
            
            //$data['prod_butt']=$landingData['prod_butt'];

            
            $data['head']=$this->load->controller('landing/head',$contact_data_referrer);
            $data['header']=$this->load->controller('landing/header',$contact_data_referrer);
            $data['footer']=$this->load->controller('landing/footer',$contact_data_referrer);
            $data['bform']=$this->load->controller('landing/bform',
                ["title"=>$data['title'],
                "landing_id"=>$landing_id,
                "block_bform_caption"=>$data["block_bform_caption"],
                "block_bform_perc"=>$data["block_bform_perc"],
                "mailthanks"=>$data["mailthanks"],
                "mailthanks_full"=>$data["mailthanks_full"],
                "mailthanks_modal"=>$data["mailthanks_modal"],
                "product_name"=>""

            ]);
            
            
            $products=[];
            $video_arr=[];
            $about=[];
            foreach($data['product_list'] as $key=>$itm){
                if($itm){
                    $products_arr[$key]=explode(",",$itm);
                    foreach($products_arr[$key] as $product_id){
                        if($product_id){
                            $product_data=$this->model_landing_landing->getProductInfo($product_id);
                            
                            $data_lp=json_decode(str_replace(array("\r\n", "\n", "\r"),'',$product_data['data_lp']),JSON_UNESCAPED_UNICODE);
                            //$data_lp['product_lp_notavail']=isset($data_lp['product_lp_notavail'])?$data_lp['product_lp_notavail']:0;
                            
                            if($data_lp['product_lp_name']){
                                $product_data['name'] =$data_lp['product_lp_name'];
                            }
                            if($data_lp['product_lp_lsi']){
                                $product_data['description_mini'] = $data_lp['product_lp_lsi'];
                            }

                            if($data['landprice']){
                                $type_price=$data['landprice'];
                            }else{
                                $type_price=$data_lp['product_lp_price'];
                            }
                            //print_r($product_data);
                            //switch ($data_lp['product_lp_price']){
                            switch ($type_price){
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
                                        $video_arr[$video_item['url']]=Array(
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
                            $data_lp['product_lp_noiden']=isset($data_lp['product_lp_noiden'])?$data_lp['product_lp_noiden']:0;

                            if(!$data_lp['product_lp_noiden']){
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
                            }
                
                            $alias="lp-".$this->model_landing_landing->getProductAlias($product_id);
                            

                            $product_data['color_product']=$color_product;
                            $product_data['alias'] = $landingAlias."/".$alias."/";
                            

                            $product_data['thumb'] = $this->model_tool_image->resize($product_data['image'], 560, 560);
                            $product_data['image'] = $product_data['image'];
                            //
                            $data_lp['product_lp_about']=isset($data_lp['product_lp_about'])?$data_lp['product_lp_about']:0;
                            ///echo "!".$product_data['product_lp_about']."!";
                            if($data_lp['product_lp_about']){
                                $about[$product_id]=[
                                    "image"=>$this->model_tool_image->resize($product_data['image'], 190, 190),
                                    "name"=>$product_data['name']
                                ];
                            }

                            $products[$key][]=$product_data;
                        }
                        
                    }
                }
            }     
            
            $data['landing_id']=$landing_id;
            $data['video']=$video_arr;
            $data['products']=$products;
            $data['about']=$about;
            
            $this->response->setOutput($this->load->view('landing/landing.tpl', $data));
        }else{
            $data['breadcrumbs'][] = array(
				'text' => "Ошибка 404: страница не найдена",
				'href' => ""
			);
            
            $this->load->language('product/product');
            $this->document->setTitle("Страница не найдена");

			$data['heading_title'] = "Страница не найдена";

			$data['text_error'] = "Страница не найдена";

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
        }
        
    }
}