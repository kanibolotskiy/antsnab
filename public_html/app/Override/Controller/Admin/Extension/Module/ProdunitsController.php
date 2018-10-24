<?php
namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Gateway\ProdUnits\ProdUnits;
use WS\Override\Gateway\ProdUnits\ProdUnitTemplates;
use WS\Override\Controller\Admin\Extension\Module\Punits\UnitsAjaxController;
use WS\Override\Controller\Admin\Extension\Module\Punits\StringsAjaxController;

/**
 * Модуль управления единицами измерения 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 * @author     https://github.com/iMateo/generator-opencart-module
 */
class ProdUnitsController extends \Controller
{

    private $error = array();
    private $error_fields = array();
    protected $data = array();

    public function index()
    {
        $this->validatePermissions();

        $this->load->language('extension/module/produnits');
        $this->setTitle('module_title');
        $this->setPartials();
        $this->setTextStrings();
        $this->addBreadcrumb('common/dashboard', 'text_home')
            ->addBreadcrumb('extension/extension', 'text_module')
            ->addBreadcrumb('extension/module/produnits', 'lists_title');

        //button actions
        $this->data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['add'] = $this->url->link('extension/module/produnits/add', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['editLink'] = $this->url->link('extension/module/produnits/edit', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['delete'] = $this->url->link('extension/module/produnits/delete', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['filter'] = $this->url->link('extension/module/produnits', 'token=' . $this->session->data['token'], 'SSL');
        

        //Specific data
        $gateway = new ProdUnitTemplates($this->registry); 

        $this->data['templates'] = $gateway->getTemplates('order by `name` ASC');
        //Send the output

        $this->fillErrors();
//        $this->response->setOutput($this->load->view('extension/module/produnits.tpl', $this->data));
        $this->response->setOutput($this->load->view('extension/module/produnits/list.tpl', $this->data));
    }

    public function add()
    {
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePermissions()) {
            if( $this->validateForm() ) {
                $addData = $this->request->post;
                $gateway = new ProdUnitTemplates($this->registry);
                $res = $gateway->add($addData);

                if( $res ) {
                    $this->session->data['success'] = $this->language->get('text_success');
                    $redirect_url =  $this->data['filter'] = $this->url->link('extension/module/produnits/edit&template_id=' . $res, 'token=' . $this->session->data['token'], 'SSL');

                    $this->response->redirect($redirect_url);
                }

                $this->error['warning'] = $this->language->get('text_add_error');
            }
		}

        $this->getForm();
    }

    public function edit()
    {
       if ( ($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validatePermissions() &&  isset( $this->request->get['template_id'] ) ) {
           if( $this->validateForm() ) {

                $updateData = $this->request->post;
                $template_id = $this->request->get['template_id'];
                $gateway = new ProdUnitTemplates($this->registry);
                $res = $gateway->update($updateData,  $template_id);

                if( $res ) {
                    $this->session->data['success'] = $this->language->get('text_success');
                    $redirect_url =  $this->data['filter'] = $this->url->link('extension/module/produnits', 'token=' . $this->session->data['token'], 'SSL');

                    $this->response->redirect($redirect_url);
                }
           }

            $this->error['warning'] = $this->language->get('text_edit_error');
		}

        $this->getForm();
    }

    public function getForm()
    {
        $this->validatePermissions();

        $this->load->language('extension/module/produnits');
        $this->setTitle('form_title');
        $this->setPartials();
        $this->setTextStrings();


        //SYSTEM
        $this->data['token'] = $this->session->data['token'];

        $template_id = null;
        if( isset( $this->request->get['template_id'] ) ) {
            $template_id = $this->request->get['template_id'];    
        }
        $this->data['templateId'] = $template_id;

        //ERRORS
        $this->fillErrors();

        //BASES 
        $unitsGateway = new ProdUnits($this->registry);
        $templatesGateWay = new ProdUnitTemplates($this->registry);
        $template = null;
        if( null !== $template_id ) {
            $this->data['priceBase'] = $unitsGateway->getBase('isPriceBase', $template_id)['unit_id'];
            $this->data['saleBase'] = $unitsGateway->getBase('isSaleBase', $template_id)['unit_id'];
            $this->data['packageBase'] = $unitsGateway->getBase('isPackageBase', $template_id)['unit_id'];
            $template = $templatesGateWay->getTemplate($template_id);
        }

        //FIELDS
        if (isset($this->request->post['name'])) {
			$this->data['name'] = $this->request->post['name'];
		} elseif (null !== $template ) {
			$this->data['name'] = $template['name'];
		} else {
			$this->data['name'] = '';
		}

        if (isset($this->request->post['description'])) {
			$this->data['description'] = $this->request->post['description'];
		} elseif (null !== $template ) {
			$this->data['description'] = $template['description'];
		} else {
			$this->data['description'] = '';
		}

        //LAST BREADCRUMBS

        if (null === $template) {
            $this->data['form_title'] = $this->data['form_title_add'] ;
            $this->setTitle('form_title_add');
            $br_url = 'extension/module/produnits/add';
        } else {
            $this->data['form_title'] = $this->data['form_title_edit'] . ' ' . $template['name'];
            $this->setTitle('form_title_edit', $template['name']);
            $br_url = 'extension/module/produnits/edit&template_id=' . $template_id;
        }

        $this->addBreadcrumb('common/dashboard', 'text_home')
             ->addBreadcrumb('extension/extension', 'text_module')
             ->addBreadcrumb('extension/module/produnits', 'lists_title')
             ->addBreadcrumb($br_url, $this->data['form_title']);

        $this->data['cancel'] = $this->url->link('extension/module/produnits', 'token=' . $this->session->data['token'] . '&category_id=' . $template_id, 'SSL');

        $this->response->setOutput($this->load->view('extension/module/produnits/form.tpl', $this->data));
    }

    public function delete()
    {
        if (isset($this->request->post['selected']) && $this->validatePermissions()) {

            $gateway = new ProdUnitTemplates($this->registry);

            foreach ($this->request->post['selected'] as $template_id) {
                $gateway->delete($template_id);
            }

            $this->load->language('extension/module/produnits');
            $this->session->data['success'] = $this->language->get('text_success');


            $this->response->redirect($this->url->link('extension/module/produnits', 'token=' . $this->session->data['token'] . $url, 'SSL'));
        }

        $this->index();
    }

    /*
     *
     * Check that user actions are authorized
     *
     */

    private function validatePermissions()
    {
        if (!$this->user->hasPermission('modify', 'extension/module/produnits')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }

        if (!$this->error) {
            return TRUE;
        } else {
            return FALSE;
        }
    }

    private function validateForm()
    {
       $this->load->language('extension/module/produnits');

       if( empty( trim($this->request->post['name']) ) ) {
           $this->error_fields['name'] = $this->language->get('error_name');
       }

       /*if( empty( trim($this->request->post['description']) ) ) {
           $this->error_fields['description'] = $this->language->get('error_description');
       }*/

       $res = true;
       if( !empty( $this->error_fields ) ) {
            $res = false;
            $this->error['warning'] = $this->language->get('error_warning'); 
       }
    
       return $res;
    }

    /**
     * Maps validation errors to $data array
     */
    protected function fillErrors()
    {
        //error handling
        $this->data['error_warning'] = '';
        if (isset($this->error['warning'])) {
            $this->data['error_warning'] = $this->error['warning'];
        } 
        $this->data['error_fields'] = $this->error_fields; 
    }

    protected function setTextStrings()
    {
        foreach ($this->language->all() as $k => $v) {
            $this->data[$k] = $v;
        }
    }

    protected function setTitle($langKey, $additional = '')
    {
        $this->document->setTitle($this->language->get($langKey) . ' ' . $additional);
    }

    protected function setPartials()
    {
        $this->data['header'] = $this->load->controller('common/header');
        $this->data['column_left'] = $this->load->controller('common/column_left');
        $this->data['footer'] = $this->load->controller('common/footer');
    }

    protected function addBreadcrumb($urlRoute, $langKey, $additional = '')
    {
        if (!isset($this->data['breadcrumbs'])) {
            $this->data['breadcrumbs'] = array();
        }

        $this->data['breadcrumbs'][] = array(
            'text' => $this->language->get($langKey) . ' ' . $additional,
            'href' => $this->url->link($urlRoute, 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        return $this;
    }

    /** Necessary for module methods */
    public function install()
    {

    }

    public function uninstall()
    {

    }

    /** AJAX for produnits @task move to certain classes, need to refactor OC*/
    public function saveUnit()
    {
        (new UnitsAjaxController($this->registry))->save();
    }

    public function getUnits()
    {
       (new UnitsAjaxController($this->registry))->getAll(); 
    }

    public function deleteunit()
    {
        (new UnitsAjaxController($this->registry))->delete();  
    }

    public function changebase()
    {
        (new UnitsAjaxController($this->registry))->changeBase();    
    }

    /** AJAX for strings @task move to certain classes, need to refactor OC*/
    public function generatestrings()
    {
        (new StringsAjaxController($this->registry))->generate();
    }

    public function saveAll()
    {
        (new StringsAjaxController($this->registry))->saveAll();
    }

    public function getStrings()
    {
       (new StringsAjaxController($this->registry))->getAll(); 
    }
}
