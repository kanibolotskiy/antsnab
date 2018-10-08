<?php

namespace WS\Override\Controller\Admin\Extension\Module;

use WS\Override\Controller\Admin\Extension\AModuleController;

/**
 * Случайные отзывы на главной странице 
 * 
 * @version    1.0, Mar 28, 2018  2:00:25 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ReviewController extends AModuleController
{

    const DEFAULT_REVIEWS_COUNT = 4;
    const DEFAULT_REVIEWS_VISIBLE = 2;
    const CONFIG_KEY_COUNT = 'review_count';
    const CONFIG_KEY_VISIBLE = 'review_visible';

    protected function getCode()
    {
        return 'review';
    }

    public function index()
    {
        parent::commonIndex();

        $this->data['entry_count'] = $this->language->get('entry_count');
        $this->data['entry_visible'] = $this->language->get('entry_visible');
        $this->data['error_empty_line'] = $this->language->get('error_empty_line');


        if (isset($this->error['error_entries'])) {
            $this->data['error_entries'] = $this->error['error_entries'];
        } else {
            $this->data['error_entries'] = '';
        }

        // entry
        if (isset($this->request->post['review_count'])) {
            $this->data['review_count'] = $this->request->post['review_count'];
        } else {
            $this->data['review_count'] = $this->config->get(static::CONFIG_KEY_COUNT);
        }
        if (isset($this->request->post['review_visible'])) {
            $this->data['review_visible'] = $this->request->post['review_visible'];
        } else {
            $this->data['review_visible'] = $this->config->get(static::CONFIG_KEY_VISIBLE);
        }

        $this->response->setOutput($this->load->view('extension/module/app/review', $this->data));
    }

    public function install()
    {
        parent::install();

        $sql = "insert into " . DB_PREFIX . "_setting (store_id, code, `key`, `value`, serialized) values" .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_COUNT . "'," . static::DEFAULT_REVIEWS_COUNT . ", false), " .
            " (0, '" . $this->getCode() . "', '" . static::CONFIG_KEY_VISIBLE . "'," . static::DEFAULT_REVIEWS_VISIBLE . ", false), ";
        return $this->db->query($sql);
    }

    public function uninstall()
    {
        parent::uninstall();

        $sql = "delete from " . DB_PREFIX . "_setting where code='" . $this->getCode() . "'";
        return $this->db->query($sql);
    }

}
