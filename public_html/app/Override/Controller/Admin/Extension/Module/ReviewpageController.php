<?php
namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Controller\Admin\Extension\AModuleController;

/**
 * Вывод отзывов на странице отзывов 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewpageController extends AModuleController
{
    const DEFAULT_REVIEWS_COUNT = 4;
    const DEFAULT_REVIEWS_RAITING = 5;
    const RULES_INFORMATION_PAGE_ID = 5;

    const CONFIG_KEY_COUNT = 'reviewpage_count';
    const CONFIG_KEY_RAITING = 'reviewpage_raiting';
    const CONFIG_KEY_RULE_ID = 'reviewpage_ruleid';

    protected function getCode()
    {
        return 'reviewpage';
    }

    public function index()
    {
        parent::commonIndex();

        $this->data['entry_count'] = $this->language->get('entry_count');
        $this->data['entry_raiting'] = $this->language->get('entry_raiting');
        $this->data['entry_ruleid'] = $this->language->get('entry_ruleid');


        if (isset($this->error['error_entries'])) {
            $this->data['error_entries'] = $this->error['error_entries'];
        } else {
            $this->data['error_entries'] = '';
        }

        // entry
        if (isset($this->request->post[static::CONFIG_KEY_COUNT ])) {
            $this->data[static::CONFIG_KEY_COUNT ] = $this->request->post[static::CONFIG_KEY_COUNT ];
        } else {
            $this->data[static::CONFIG_KEY_COUNT ] = $this->config->get(static::CONFIG_KEY_COUNT);
        }
        
        if (isset($this->request->post[static::CONFIG_KEY_RAITING ])) {
            $this->data[static::CONFIG_KEY_RAITING ] = $this->request->post[static::CONFIG_KEY_RAITING ];
        } else {
            $this->data[static::CONFIG_KEY_RAITING ] = $this->config->get(static::CONFIG_KEY_RAITING);
        }

        if (isset($this->request->post[static::CONFIG_KEY_RULE_ID ])) {
            $this->data[static::CONFIG_KEY_RULE_ID ] = $this->request->post[static::CONFIG_KEY_RULE_ID ];
        } else {
            $this->data[static::CONFIG_KEY_RULE_ID ] = $this->config->get(static::CONFIG_KEY_RULE_ID);
        }
       

       $this->response->setOutput($this->load->view('extension/module/app/reviewpage', $this->data));
    }

    public function install()
    {
        parent::install();

        $sql = "insert into " . DB_PREFIX . "_setting (store_id, code, `key`, `value`, serialized) values" .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_COUNT . "',".static::DEFAULT_REVIEWS_COUNT.", false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_RAITING . "',".static::DEFAULT_REVIEWS_RAITING.", false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_RULE_ID . "'," . static::RULES_INFORMATION_PAGE_ID . ", false), ";
        return $this->db->query($sql);
    }

    public function uninstall()
    {
        parent::uninstall();

        $sql = "delete from " . DB_PREFIX . "_setting where code='" . $this->getCode() . "'";
        return $this->db->query($sql);
    }

}
