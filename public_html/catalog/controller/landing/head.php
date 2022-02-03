<?php
class ControllerLandingHead extends Controller {
	public function index($contact_data_referrer) {
        $scheme = isset($_SERVER['HTTP_SCHEME']) ? $_SERVER['HTTP_SCHEME'] : (
            (
         (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ||
          443 == $_SERVER['SERVER_PORT']
            ) ? 'https://' : 'http://'
        
        );
        $data['base']=$scheme.$_SERVER['HTTP_HOST'];
        $data['meta_title']=$contact_data_referrer['meta_description'];
        $data['meta_description']=$contact_data_referrer['meta_description'];
        return $this->load->view('landing/head', $data);
    }
}
?>