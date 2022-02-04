<?php
class ControllerLandingFooter extends Controller {
	public function index($contact_data_referrer) {
		$data=$contact_data_referrer;
        if(isset($contact_data_referrer['phone'])){
			$data['telephone'] = $contact_data_referrer['phone'];
			$data['telephone_link'] = preg_replace('/[^0-9]/', '', $contact_data_referrer['phone']);
			$data['telephone2'] = '';
		}else{
			$data['telephone'] = $this->config->get('config_telephone');
			$data['telephone_link'] = preg_replace('/[^0-9]/', '', $this->config->get('config_telephone'));
			$data['telephone2'] = $this->config->get('config_fax');
			$data['telephone2_link'] = preg_replace('/[^0-9]/', '', $this->config->get('config_fax')); 
		}
		if(isset($contact_data_referrer['email'])){
			$data['email_site']=$contact_data_referrer['email'];
		}else{
			$data['email_site']=$this->config->get('config_email_site');
		}

        $data['link_vk']=$this->config->get('config_soc_vk');
        $data['link_fb']=$this->config->get('config_soc_fb');
        $data['link_tw']=$this->config->get('config_soc_tw');
        $data['link_in']=$this->config->get('config_soc_in');

        $data['m_telegram']=$this->config->get('config_m_telegram');
        $data['m_whatsapp']=$this->config->get('config_m_whatsapp');
        $data['m_viber']=$this->config->get('config_m_viber');
        
        return $this->load->view('landing/footer', $data);
    }
}
?>