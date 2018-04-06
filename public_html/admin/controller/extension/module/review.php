<?php
//@task эти методы не работают,когда используютс в оверрайд-контроллере. переделать
//see ControllerExtensionExtensionModule::install() и \Loader::controller(); 

class ControllerExtensionModuleReview extends Controller {
    public function install()
    {
        $this->load->model('extension/module/review');
        return $this->model_extension_module_review->installDatabase();
    }

    public function uninstall()
    {
        $this->load->model('extension/module/review');
        return $this->model_extension_module_review->uninstallDatabase();
    }
}