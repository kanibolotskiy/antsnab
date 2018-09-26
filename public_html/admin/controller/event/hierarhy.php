<?php
use WS\Override\Gateway\Hierarhy as Hierarhy;

class ControllerEventHierarhy extends Controller 
{
    public function refresh()
    {
        $hierarhy = new Hierarhy($this->registry);
        $hierarhy->refresh();
    }
}

