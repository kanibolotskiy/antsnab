<?php
class ControllerLandingHeader extends Controller {
	public function index($contact_data_referrer) {

        $data['logotext']=$contact_data_referrer['logotext'];
        

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
        return $this->load->view('landing/header', $data);
    }
}
?>