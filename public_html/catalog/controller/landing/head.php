<?php
class ControllerLandingHead extends Controller {
	public function index($contact_data_referrer) {
        $scheme = isset($_SERVER['HTTP_SCHEME']) ? $_SERVER['HTTP_SCHEME'] : (
            (
         (isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] != 'off') ||
          443 == $_SERVER['SERVER_PORT']
            ) ? 'https://' : 'http://'
        
        );
        $base_url=$scheme.$_SERVER['HTTP_HOST']."/";
        $data['base']=$base_url;
        $data['url']=$base_url.$contact_data_referrer['url']."/";
        $data['meta_title']=$contact_data_referrer['meta_title'];
        $data['meta_description']=$contact_data_referrer['meta_description'];
        $data['image']=$base_url."image/".$contact_data_referrer['image'];
        return $this->load->view('landing/head', $data);
    }
}
?>