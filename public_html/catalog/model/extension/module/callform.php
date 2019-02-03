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
class ModelExtensionModuleCallform extends Model
{

    const CONFIG_ALERT_IDENTITY = 'order';

    public function add($data)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "callform SET `name` ='" . $this->db->escape($data['name']) . "', phone = '" . $this->db->escape($data['phone']) . "', `text` = '" . $this->db->escape($data['text']) . "', date_added = NOW()");

        $call_id = $this->db->getLastId();

        //@moved to private
        $this->sendMail($data);

        return $call_id;
    }

    protected function sendMail($data)
    {
        if (in_array(static::CONFIG_ALERT_IDENTITY, (array) $this->config->get('config_mail_alert'))) {
            $this->load->language('extension/module/callform');


            //$subject = sprintf($this->language->get('text_subject'), html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));

            //@task make from language variables or tpl 
            
            /*
            $message = '<p>Заказ звонка</p>
            <table style="border-collapse:collapse;">
            <tr>
                <td style="padding:4px 10px;border:1px solid #ccc;"><b>Имя:</b></td>
                <td style="padding:4px 10px;border:1px solid #ccc;">'.$data["name"].'</td>
            </tr>
            <tr>
                <td style="padding:4px 10px;border:1px solid #ccc;"><b>Телефон:</b></td>
                <td style="padding:4px 10px;border:1px solid #ccc;">'.$data["phone"].'</td>
            </tr>
            <tr>
                <td style="padding:4px 10px;border:1px solid #ccc;"><b>Сообщение:</b></td>
                <td style="padding:4px 10px;border:1px solid #ccc;">'.$data["text"].'</td>
            </tr>
            </table>';
            */
            $data["logo"]= $this->config->get('config_url') . 'image/' . $this->config->get('config_logo');

            $this->load->model('checkout/order');
            if($this->model_checkout_order->OfficeWorkTime()){
                $data["caption"]=$this->language->get('text_caption_worktime');
                $subject=$this->language->get('text_subject_worktime');

                //Инициировать звонок
            }else{
                $data["caption"]=$this->language->get('text_caption_notworktime');
                $subject=$this->language->get('text_subject_notworktime');
            }
            
            
            //$data["data"]=date("d.m.Y H:i");

            $data["data_content"][]=array("Имя клиента",$data['name']);
            $data["data_content"][]=array("Телефон",$data['phone']);
            $data["data_content"][]=array("Сообщение",$data['text']);
            $data["data_content"][]=array("Дата события",date("d.m.Y H:i"));
            

            $message = $this->load->view('extension/call_report', $data);

            $mail = new Mail();
            $mail->protocol = $this->config->get('config_mail_protocol');
            $mail->parameter = $this->config->get('config_mail_parameter');
            $mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
            $mail->smtp_username = $this->config->get('config_mail_smtp_username');
            $mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
            $mail->smtp_port = $this->config->get('config_mail_smtp_port');
            $mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

            $mail->setTo($this->config->get('config_email'));
            $mail->setFrom($this->config->get('config_email'));
            $mail->setSender(html_entity_decode($this->config->get('config_name'), ENT_QUOTES, 'UTF-8'));
            $mail->setSubject($subject);
            $mail->setHTML($message);
            $mail->send();

            // Send to additional alert emails
            $emails = explode(',', $this->config->get('config_alert_email'));

            foreach ($emails as $email) {
                if ($email && preg_match($this->config->get('config_mail_regexp'), $email)) {
                    $mail->setTo($email);
                    $mail->send();
                }
            }
        }
    }

    /** @task move to module installation */
    public function install()
    {
        $sql = "create table oc_callform (
    callform_id int(11) not null AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(255) not null default '',
    `phone` varchar(100) not null default '',
    `text` varchar(2000) not null default '',
    `date_added` timestamp not null default current_timestamp
) engine = MyISAM, charset=utf8;";
    }

}
