<?php
class ControllerLandingBform extends Controller {
	public function index($data) {
        return $this->load->view('landing/bform', $data);
    }
}
?>