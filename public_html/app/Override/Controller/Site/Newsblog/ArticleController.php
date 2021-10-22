<?php

/**
 * @category WS patches 
 * @package  WS\Override\Controller\Site\Newsblog
 */

namespace WS\Override\Controller\Site\Newsblog;

//put your use statements here

/**
 * Описание класса 
 * 
 * @version    1.0, Apr 12, 2018  2:48:19 AM 
 * @copyright  Copyright (c) 2018 AntSnab. (https://www.ant-snab.ru)
 * @author     Sergey Lapshin (http://vk.com/wslapshin) 
 */
class ArticleController extends \Controller
{

    public function index()
    {
        $this->load->language('newsblog/article');

        $data['breadcrumbs'] = array();

        $data['breadcrumbs'][] = array(
            'text' => $this->language->get('text_home'),
            'href' => $this->url->link('common/home')
        );

        $this->load->model('newsblog/category');

        $category_info = false;
        $settings = false;

        $images_size_articles_big = array($this->config->get($this->config->get('config_theme') . '_image_popup_width'), $this->config->get($this->config->get('config_theme') . '_image_popup_height'));
        $images_size_articles_small = array($this->config->get($this->config->get('config_theme') . '_image_thumb_width'), $this->config->get($this->config->get('config_theme') . '_image_thumb_height'));

        if (isset($this->request->get['newsblog_path'])) {
            
            $newsblog_path = '';

            $parts = explode('_', (string) $this->request->get['newsblog_path']);

            //@added
            $top_category_id = $parts[0];

            $category_id = (int) array_pop($parts);


            foreach ($parts as $newsblog_path_id) {

                if (!$newsblog_path) {
                    $newsblog_path = $newsblog_path_id;
                } else {
                    $newsblog_path .= '_' . $newsblog_path_id;
                }

                $category_info = $this->model_newsblog_category->getCategory($newsblog_path_id);

                if ($category_info) {
                    $data['breadcrumbs'][] = array(
                        'text' => $category_info['name'],
                        'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $newsblog_path)
                    );
                }
            }

            // Set the last category breadcrumb
            $category_info = $this->model_newsblog_category->getCategory($category_id);

            if ($category_info) {
                $data['breadcrumbs'][] = array(
                    'text' => $category_info['name'],
                    'href' => $this->url->link('newsblog/category', 'newsblog_path=' . $this->request->get['newsblog_path'])
                );

                //for no errors with versions < 20160920
                if ($category_info['settings']) {
                    $settings = unserialize($category_info['settings']);

                    $images_size_articles_big = array($settings['images_size_articles_big_width'], $settings['images_size_articles_big_height']);
                    $images_size_articles_small = array($settings['images_size_articles_small_width'], $settings['images_size_articles_small_height']);
                }
            }
        }

        if (isset($this->request->get['newsblog_article_id'])) {
            $newsblog_article_id = (int) $this->request->get['newsblog_article_id'];
        } else {
            $newsblog_article_id = 0;
        }

        $this->load->model('newsblog/article');

        $article_info = $this->model_newsblog_article->getArticle($newsblog_article_id);

        if ($article_info) {
            $url = '';

            if (isset($this->request->get['newsblog_path'])) {
                $url .= '&newsblog_path=' . $this->request->get['newsblog_path'];
            }

            if (isset($this->request->get['tag'])) {
                $url .= '&tag=' . $this->request->get['tag'];
            }

            $data['breadcrumbs'][] = array(
                'text' => $article_info['name'],
                'href' => $this->url->link('newsblog/article', $url . '&newsblog_article_id=' . $newsblog_article_id)
            );

            if ($article_info['meta_title']) {
                $this->document->setTitle($article_info['meta_title']);
            } else {
                $this->document->setTitle($article_info['name']);
            }

            $this->document->setDescription($article_info['meta_description']);
            $this->document->setKeywords($article_info['meta_keyword']);
            $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($newsblog_article_id);
            $data['canonical'] = $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $newsblog_article_id);
            $this->document->addLink($data['canonical'], 'canonical');
            $this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js');
            $this->document->addStyle('catalog/view/javascript/jquery/magnific/magnific-popup.css');

            if ($article_info['meta_h1']) {
				$meta_h1 = $article_info['meta_h1'];
			} else {
				$meta_h1 = $article_info['name'];
            }
            
            $data['heading_title'] = $meta_h1;

            if($article_info['meta_keyword']){
				$this->document->setKeywords($article_info['meta_keyword']);
			}else{
				$this->document->setKeywords($meta_h1);
            }
            


            $data['text_tags'] = $this->language->get('text_tags');
            $data['text_related'] = $this->language->get('text_related');
            $data['text_related_products'] = $this->language->get('text_related_products');
            $data['text_attributes'] = $this->language->get('text_attributes');

            //for related products
            $this->load->language('product/product');
            $data['text_tax'] = $this->language->get('text_tax');
            $data['button_cart'] = $this->language->get('button_cart');
            $data['button_wishlist'] = $this->language->get('button_wishlist');
            $data['button_compare'] = $this->language->get('button_compare');

            $data['article_id'] = $newsblog_article_id;

            $this->load->model('tool/image');

            if ($article_info['image']) {
                $thumb = $this->model_tool_image->resize($article_info['image'], 660,440);
                $image_webp=str_replace(".jpg",".webp",$thumb);
                $image_webp=str_replace(".png",".webp",$image_webp);

                $data['original'] = HTTP_SERVER . 'image/' . $article_info['image'];
                $data['popup'] = $this->model_tool_image->resize($article_info['image'], $images_size_articles_big[0], $images_size_articles_big[1]);
                $data['thumb'] = $thumb;
                $data['thumb_webp'] = $image_webp;

                $this->document->setOgimage($data['original']);
            } else {
                $data['original'] = false;
                $data['popup'] = false;
                $data['thumb'] = false;
                $data['thumb_webp'] =false;
            }
            
            //$data['og_image']=$data['original'];
            


            /** @todo  hardcoded */
            $settings['desc_limit'] = 65;
			$preview = html_entity_decode($article_info['preview'], ENT_QUOTES, 'UTF-8');
			if( empty($preview) ) {
				$preview = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');
			}
            $preview = mb_substr($preview, 0, $settings['desc_limit']) . '...';

            if ($settings && $settings['show_preview'])
                $data['preview'] = $preview;
            else
                $data['preview'] = '';

            $this->load->model('catalog/information');
            $data['description'] = $this->model_catalog_information->cleanText($article_info['description']);

            //$data['description'] = html_entity_decode($article_info['description'], ENT_QUOTES, 'UTF-8');
            
            $data['images'] = array();
            
            $results = $this->model_newsblog_article->getArticleImages($newsblog_article_id);

            foreach ($results as $result) {
                $thumb = $this->model_tool_image->myResize($result['image'], $images_size_articles_small[0], $images_size_articles_small[1],1);
                $image_webp=str_replace(".jpg",".webp",$thumb);
                $image_webp=str_replace(".png",".webp",$image_webp);

                $data['images'][] = array(
                    'original' => HTTP_SERVER . 'image/' . $result['image'],
                    'popup' => $this->model_tool_image->resize($result['image'], $images_size_articles_big[0], $images_size_articles_big[1]),
                    'thumb' => $thumb,
                    'thumb_webp' => $image_webp,
                );
            }


            $data['attributes'] = $article_info['attributes'];

            $data['href'] = $this->url->link('newsblog/article', 'newsblog_article_id=' . $newsblog_article_id);

            $date_format = $this->language->get('date_format_short');
            if ($settings)
                $date_format = $settings['date_format'];

            $data['date'] = ($date_format ? date($date_format, strtotime($article_info['date_available'])) : false);

            //@added 
            $data['show_cat_name'] = ( $top_category_id == CategoryController::ARTICLES_CATEGORY_ID )?true:false;
            $data['cat_name'] = $article_info['cat_name'];



            $data['date_modified'] = ($date_format ? date($date_format, strtotime($article_info['date_modified'])) : false);

            $data['viewed'] = $article_info['viewed'];

            $data['articles'] = array();

            $results = $this->model_newsblog_article->getArticleRelated($newsblog_article_id);

            foreach ($results as $result) {

                if ($result['image']) {
                    $original = HTTP_SERVER . 'image/' . $result['image'];
                    $thumb = $this->model_tool_image->resize($result['image'], $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
                    //$thumb = $this->model_tool_image->resize($result['image'], 660, 440);

                } else {
                    $original = false;
                    $thumb = false;
                }

                $mainCategoryId = $this->model_newsblog_article->getArticleMainCategoryId($result['article_id']);

                $preview = html_entity_decode($result['preview'], ENT_QUOTES, 'UTF-8');
                if( empty($preview) ) {
                    $preview = html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8');
                }
                /** @todo hardcoded later */
                $preview = mb_substr($preview, 0, $settings['desc_limit']) . '...';


                $image_webp=str_replace(".jpg",".webp",$thumb);
                $image_webp=str_replace(".png",".webp",$image_webp);

                $data['articles'][] = array(
                    'article_id' => $result['article_id'],
                    'original' => $original,
                    'thumb' => $thumb,
                    'thumb_webp' => $image_webp,
                    'name' => $result['name'],
                    'preview' => $preview,
                    'attributes' => $result['attributes'],
                    'href' => $this->url->link('newsblog/article', 'newsblog_path=' . $mainCategoryId . '&newsblog_article_id=' . $result['article_id']),
                    'date' => ($date_format ? date($date_format, strtotime($result['date_available'])) : false),
                    'date_modified' => ($date_format ? date($date_format, strtotime($result['date_modified'])) : false),
                    'viewed' => $result['viewed']
                );
            }


            $data['products'] = array();

            $this->load->model('catalog/product');
            $results = $this->model_newsblog_article->getArticleRelatedProducts($newsblog_article_id, 4, true);//4 items, order by rand

            foreach ($results as $result) {
                if ($result['image']) {
                    $image = $this->model_tool_image->resize($result['image'], 280,280);
                } else {
                    $image = $this->model_tool_image->resize('placeholder.png', $this->config->get($this->config->get('config_theme') . '_image_related_width'), $this->config->get($this->config->get('config_theme') . '_image_related_height'));
                }

                if ($this->customer->isLogged() || !$this->config->get('config_customer_price')) {
                    $price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $price = false;
                }

                if ((float) $result['special']) {
                    $special = $this->currency->format($this->tax->calculate($result['special'], $result['tax_class_id'], $this->config->get('config_tax')), $this->session->data['currency']);
                } else {
                    $special = false;
                }

                if ($this->config->get('config_tax')) {
                    $tax = $this->currency->format((float) $result['special'] ? $result['special'] : $result['price'], $this->session->data['currency']);
                } else {
                    $tax = false;
                }

                if ($this->config->get('config_review_status')) {
                    $rating = (int) $result['rating'];
                } else {
                    $rating = false;
                }

                $image_webp=str_replace(".jpg",".webp",$image);
                $image_webp=str_replace(".png",".webp",$image_webp);

                /** @changed name is meta_h1 */
                $data['products'][] = array(
                    'product_id' => $result['product_id'],
                    'thumb' => $image,
                    'thumb_webp' => $image_webp,
                    'name' => $result['name'],
                    'meta_h1' => $result['meta_h1'],
                    'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get($this->config->get('config_theme') . '_product_description_length')) . '..',
                    'price' => $price,
                    'special' => $special,
                    'tax' => $tax,
                    'minimum' => $result['minimum'] > 0 ? $result['minimum'] : 1,
                    'rating' => $rating,
                    'href' => $this->url->link('product/product', 'product_id=' . $result['product_id'])
                );
            }

            $data['tags'] = array();

            if ($article_info['tag']) {
                $tags = explode(',', $article_info['tag']);

                foreach ($tags as $tag) {
                    $data['tags'][] = array(
                        'tag' => trim($tag),
                        'href' => $this->url->link('product/search', 'tag=' . trim($tag))
                    );
                }
            }

            //for no errors with versions < 20170906
            $data['comments_vk'] = false;
            $data['comments_fb'] = false;
            $data['comments_dq'] = false;
            if ($settings && isset($settings['show_comments_vk_id'])) {
                if ($settings && $settings['show_comments_vk_id'] && $settings['show_comments_vk_article']) {
                    $data['comments_vk'] = $settings['show_comments_vk_id'];
                    $this->document->addScript('//vk.com/js/api/openapi.js');
                }

                if ($settings && $settings['show_comments_fb_article'])
                    $data['comments_fb'] = true;

                if ($settings && $settings['show_comments_dq_id'] && $settings['show_comments_dq_article'])
                    $data['comments_dq'] = $settings['show_comments_dq_id'];
            }
            
            $data['faq']=$this->model_newsblog_article->getArticleFaq($newsblog_article_id);


            $this->model_newsblog_article->updateViewed($this->request->get['newsblog_article_id']);

            $data['column_left'] = $this->load->controller('common/column_left');
            $data['column_right'] = $this->load->controller('common/column_right');
            $data['content_top'] = $this->load->controller('common/content_top');
            $data['content_bottom'] = $this->load->controller('common/content_bottom');
            $data['footer'] = $this->load->controller('common/footer');
            $data['header'] = $this->load->controller('common/header');

            $template_default = 'article.tpl';
            if ($settings && $settings['template_article'])
                $template_default = $settings['template_article'];

            
            $this->response->setOutput($this->load->view('newsblog/' . $template_default, $data));
        } else {
            //print_r($data);
            /*
            $data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('newsblog/category')
            );
            */
            

            $data['breadcrumbs'] = [];
            $data['breadcrumbs'][] = array(
                'text' => $this->language->get('text_home'),
                'href' => $this->url->link('common/home')
            );


            /**Страница ошибки 404 */
            $this->load->model('catalog/information');
            $information_id = 10;
            $information_info = $this->model_catalog_information->getInformation($information_id);

            //$data['cart_text']=html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8');0

            //print_r($information_info);
            $this->document->setTitle($information_info['title']);
            $data['breadcrumbs'][] = array(
                'text' => $information_info['title'],
                'href' => ''
            );

			$data['heading_title'] = $information_info['title'];

            $data['text_error'] = html_entity_decode($information_info['description']);
            
/*
			$data['button_continue'] = $this->language->get('button_continue');
			$data['continue'] = $this->url->link('common/home');
*/
			//$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');
            $this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . '/1.1 404 Not Found');
			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found.tpl', $data));

        }
    }

}
