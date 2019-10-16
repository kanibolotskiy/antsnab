<?php

/**
 * @category WS patches 
 * @package  
 */

/**
 * Описание класса 
 * 
 * @task move to model overrides 
 * @version    1.0, Apr 4, 2018  11:48:03 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ModelExtensionModuleFeedback extends Model
{    
    const CONFIG_ALERT_IDENTITY = 'order';

    public function add($data)
    {
        ///$this->db->query("INSERT INTO " . DB_PREFIX . "callform SET `name` ='" . $this->db->escape($data['name']) . "', phone = '" . $this->db->escape($data['phone']) . "', `text` = '" . $this->db->escape($data['text']) . "', date_added = NOW()");
        //$call_id = $this->db->getLastId();
        //@moved to private
        
        return $this->sendMail($data);
    }


    protected function sendMail($data)
    {
        if (in_array(static::CONFIG_ALERT_IDENTITY, (array) $this->config->get('config_mail_alert'))) {
            
            $this->load->language('extension/module/callform');
 
           
            $data_message['logo']='https://ant-snab.ru/image/catalog/logo.jpg';

            $data_message["caption"]=$this->language->get('text_caption_feedback');
            $subject=$this->language->get('text_subject_feedback');
            
            $data_message["data"]=date("d.m.Y H:i");
            $data_message["data_content"][]=array("Имя клиента",$data['name']);
            $data_message["data_content"][]=array("Телефон",$data['phone']);
            $data_message["data_content"][]=array("Email",$data['email']);
            $data_message["data_content"][]=array("Сообщение",$data['text']);
            $data_message["data_content"][]=array("Дата события",date("d.m.Y H:i"));
            
            
            $message = $this->load->view('extension/feedback_report', $data_message);
            
            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');
            $mail->setTo($this->config->get('config_email_feedback'));
            
            $mail->setFrom($this->config->get('config_email'));
            $mail->setHTML($message);
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            $mail->setSubject($subject);
            
            $mail->send();
            
                   
        }
        return true;
    }
}
