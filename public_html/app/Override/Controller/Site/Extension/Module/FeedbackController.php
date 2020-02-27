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
class FeedbackController extends \Controller
{

    private $formError = array();

    /**
     * Форма обратный звонок
     */
    public function index()
    {
        
        $data = array();
        $this->formError = array();
        
        if ($this->request->server['REQUEST_METHOD'] == 'POST') {
            if ($this->validateFeedbackForm($this->request->post)) {
                $this->load->model('extension/module/feedback');
                
                $result = $this->model_extension_module_feedback->add($this->request->post);
                
                if ($result) {
                    $data['success']=true;
                }
                
            }
        } 
        
        $data['errors'] = $this->formError;
        $this->response->setOutput(json_encode($data));
       
    }

    public function validateFeedbackForm()
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

        if (utf8_strlen($this->request->post['text']) > 2000) {
            $this->formError['text']  = $this->language->get('error_text');
        }

        return !$this->formError;
    }

}
