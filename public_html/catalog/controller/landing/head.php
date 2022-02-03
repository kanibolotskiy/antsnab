<?php
class ControllerLandingHead extends Controller {
	public function index($contact_data_referrer) {
        $data['meta_title']=$contact_data_referrer['meta_description'];
        $data['meta_description']=$contact_data_referrer['meta_description'];
        return $this->load->view('landing/head', $data);
    }
}
?>