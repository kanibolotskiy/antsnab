<?php
/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Common
 */

namespace WS\Override\Controller\Site\Extension\Module;

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 4, 2018  10:59:14 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class CallformController extends \Controller
{

    private $formError = array();

    /**
     * Форма обратный звонок
     */
    public function index()
    {
        
        $data = array();
        //$data['show_thankyou'] = false;
        $this->formError = array();
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ($this->validateCallForm($this->request->post)) {
                $this->load->model('extension/module/callform');
                
                $result = $this->model_extension_module_callform->add($this->request->post);
                
                if ($result) {
                    $data['success']=true;
                    //$data['show_thankyou'] = true;
                }
            }
        }
        //$data['workemail']='';
        $data['errors'] = $this->formError;
        //$data['data'] = $this->request->post;
        //$redirect = $this->request->post['redirect'];

        //$this->session->data['callform'] = $data;
        /*
        $this->response->redirect($redirect);
        */

        //$json["success"]=true;
        $this->response->setOutput(json_encode($data));

    }

    public function validateCallForm()
    {
        
        $this->load->language('extension/module/callform');

        if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 255)) {
            $this->formError['name'] = $this->language->get('error_name');
        }

        if ( empty($this->request->post['phone']) ) {
            $this->formError['phone'] = $this->language->get('error_phone');
        }

        if (!empty($this->request->post['workemail']) ) {
            $this->formError['workemail'] = $this->language->get('error_phone');
        }

        /*
         else {
            $trimmedPhone = preg_replace('~\D~', '', $this->request->post['phone']);
            if( strlen($trimmedPhone) != 10 ) {
                $this->formError['phone'] = $this->language->get('error_phone2');
            }
        }
        */

        if (utf8_strlen($this->request->post['text']) > 2000) {
            $this->formError['text']  = $this->language->get('error_text');
        }
        // Captcha
        $pageName = 'contact';
        
        if ($this->config->get($this->config->get('config_captcha') . '_status') && in_array($pageName, (array) $this->config->get('config_captcha_page'))) {
            $captcha = $this->load->controller('extension/captcha/' . $this->config->get('config_captcha') . '/validate');

            if ($captcha) {
                $this->formError['captcha'] = $captcha;
            }
        }

        return !$this->formError;
    }

}
