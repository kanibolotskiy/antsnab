<?= $header ?>
<div class="container main">
    
    <div class="content without_sidebar">
        <?php echo $content_top; ?>
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <h1 class="title">Корзина</h1>
        
        <div id="empty_cart_block" class="empty_cart_block">
            <?php echo $empty_cart; ?>
        </div>
        <div id="full_cart_block">
            <div class="basket-container">
                <form id="cart_form" action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                    <div class="basket-block">
                        <?php foreach ($products as $product) { ?> 
                            <?php include __DIR__ . '/../partial/basket_row.tpl' ?>
                        <?php } ?>
                    </div>
                </form>

                
                <div class="summary_total_block">
                    <div class="summary_total_block_left">
                        <div class="order_weight">Вес заказа: <span><span id="order_weight"><?php echo $total_weight;?></span> кг</span></div>
                    </div>
                    <div class="summary_total_block_right">
                        <?php foreach ($totals as $total): ?>
                            <div class="recalc intotal"><?php echo $total['title']; ?>: <span class="total_cart_span" id="total_cart"><?php echo $total['text']; ?></span></div>
                        <?php endforeach; ?>
                        

                        <div class="recalc intotal economy" style="<?php if($ecosum==0){echo 'display:none';}?>" > 
                            Вы сэкономили: <span><span id="ecosum"><?php echo $ecosum;?></span> <div class="rur">i</div></span>
                        </div>
                        
                        <!--<div class="order_weight">Ориентировочная стоимость доставки: <span><span id="order_weight_cost"><?php echo $total_del;?></span> <div class="rur">i</div></span></div>-->
                    </div>
                </div>

                
                
                <div class="ordering">
                    <div class="ordering_captions">
                        <div class="ordering_caption">Оформление заказа</div>
                        <div class="ordering_caption_items">
                            <div class="ordering_caption_item active" rel="1">
                                <div class="ordering_caption_item_num"><div class="ordering_caption_item_numval">1</div></div>
                                <div class="ordering_caption_item_cap">Контактные данные</div>
                            </div>
                            <div class="ordering_caption_item" rel="2">
                                <div class="ordering_caption_item_num"><div class="ordering_caption_item_numval">2</div></div>
                                <div class="ordering_caption_item_cap">Способ получения</div>
                            </div>
                            <div class="ordering_caption_item" rel="3">
                                <div class="ordering_caption_item_num"><div class="ordering_caption_item_numval">3</div></div>
                                <div class="ordering_caption_item_cap">Оплата</div>
                            </div>
                        </div>
                    </div>
                    <div class="ordering_info">
                        

                        <form id="order_form" method="post" enctype="multipart/form-data">
                            <input type="hidden" name="client" id="lico" value="1"/>
                            <input type="hidden" name="payment_method" id="payment_method" value="Наличными при получении" />
                            <input type="hidden" name="shipping_method" id="shipping_method" value="Самовывоз" />

                            <div class="order_blocks">
                                <div class="order_block" rel="1">
                                    <div class="wrp_ordering_types">
                                        <div class="ordering_types">
                                            <div class="ordering_type <?php echo $client[0];?>" rel="1" data-pay="Наличными при получении">Физическое лицо</div>
                                            <div class="ordering_type <?php echo $client[1];?>" rel="2" data-pay="Оплата по счёту для юридических лиц">Юридическое лицо</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="form-group">
                                            <div class="form-group_caption">Ваше имя <span>*</span></div>
                                            <input id="order_name" class="inpOrderText" value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите имя"/>
                                            <div class="order_error">Необходимо заполнить</div>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group_caption">Ваш телефон <span>*</span></div>
                                            <input id="order_phone" class="inpOrderText" value="<?= $form_data['phone'] ?>" name="phone" type="tel" placeholder="+7 __________"/>
                                            <div class="order_error">Необходимо заполнить</div>
                                        </div>

                                        <div class="form-group">
                                            <div class="form-group_caption">Ваша электронная почта <span class="client2 <?php echo $client[1]?'_showed':'';?>">*</span></div>
                                            <input id="order_email" class="inpOrderText" value="<?= $form_data['email'] ?>" name="email" type="text" placeholder="Введите электронную почту"/>
                                            <div class="order_error">Неверный формат</div>
                                        </div>

                                        <div class="form-group client2 <?php echo $client[1]?'_showed':'';?>" >
                                            <div class="form-group_caption">ИНН <span>*</span></div>
                                            <input id="order_inn" class="inpOrderText" class="inputInn" value="<?= $form_data['inn'] ?>" name="inn" type="text" placeholder="Введите ИНН"/>
                                            <div class="order_error">Неверный формат</div>
                                        </div>

                                        <div class="form-group file client2 <?php echo $client[1]?'_showed':'';?>" >
                                            <div class="form-group_caption form-group_caption_empt">&nbsp;</div>
                                            <div class="file-block">
                                                <div class="file-block_wrp">
                                                    
                                                    <span id="filename" class="filename_caption">прикрепить реквизиты</span>
                                                </div>
                                                <input id="file" type="file" value="" name="download">
                                            </div>
                                        </div>

                                        <div class="form-group _buttonpay client2 <?php echo $client[1]?'_showed':'';?>">
                                         
                                            <div class="order_button_next" id="order_next1">
                                                <span>Выбрать способ получения</span>
                                            </div>
                                            <!--<input type="submit" value="Заказать">-->
                                        </div>

                                    </div>
                                </div>
                                <div class="order_block" rel="2" style="display:none;">
                                    <div class="delivery_order_blocks row">
                                        <div class="delivery_order_block delivery_order_block1 active" rel="1" data-caption="Самовывоз">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_text">
                                                    <div class="delivery_order_block_caption">Самовывоз</div>
                                                    <p>г. Москва, Высоковольтный проезд, д. 1, стр. 43</p>
                                                    <p><a class="js_modal with_goal" goal="in-stock" data-modal="modal_map" href="#">Схема проезда</a></p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="delivery_order_block delivery_order_block2" rel="2" data-caption="Доставка">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_text">
                                                    <div class="delivery_order_block_caption">Доставка</div>
                                                    <p>Ориентировочная стоимость доставки по Москве от <span id="order_weight_cost"><?php echo $total_del;?></span> <span class="rur">i</span>, окончательную стоимость сообщит менеджер при подтверждении заказа.</p>
                                                    <div class="form-group">
                                                        <div class="form-group_caption">Адрес доставки <span>*</span></div>
                                                        <input id="order_address" autocomplete="new-password" class="inpOrderText inputAddress" value="<?= $form_data['shipping_address'] ?>" name="shipping_address" type="text" placeholder="Введите адрес"/>
                                                        <div class="order_error">Необходимо заполнить</div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row wrp_orderbuttons">
                                        <div class="form-group orderbutton1">
                                            <div class="delivery_navigate_prev" id="button_prev1">Вернуться назад</div>
                                        </div>
                                        <div class="form-group orderbutton2">
                                            <div class="order_button_next" id="order_next2">
                                                <span>Выбрать способ оплаты</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="order_block" rel="3" style="display:none;">
                                    
                                    <div class="payment_order_blocks" rel="1">
                                        <div class="payment_order_block active">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_cap">Наличными при получении</div>
                                            </div>
                                        </div>
                                        <div class="payment_order_block _disable with_goal" goal="cart-pay-card-online">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_cap nowrap">Картой на сайте</div>
                                                <div class="delivery_disabled">Временно недоступно</div>
                                            </div>
                                        </div>
                                        <div class="payment_order_block _disable with_goal" goal="cart-pay-card-delievery">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_cap nowrap">Картой при получении</div>
                                                <div class="delivery_disabled">Временно недоступно</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="payment_order_blocks" rel="2" style="display:none;">
                                        <div class="payment_order_block_wide payment_order_block active">
                                            <div class="delivery_order_block_info">
                                                <div class="delivery_order_block_point"></div>
                                                <div class="delivery_order_block_cap">Оплата по счёту для юридических лиц</div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row last_step_order">
                                        <div class="form-group orderbutton1">
                                            <div class="delivery_navigate_prev" id="button_prev2">Вернуться назад</div>
                                        </div>

                                        <div class="form-group orderbutton2">
                                            <button type="submit" class="order_button_next">
                                                <span>Отправить заказ</span>
                                            </button>
                                            <!--<input type="submit" value="Отправить заказ">-->

                                            <!--<div class="order_button_next" id="make_order">
                                                <span>Отправить заказ</span>
                                            </div>
                                            -->
                                            <div class="order_link_policy">
                                                <p>Нажимая на кнопку, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                                            </div>
                                        </div> 
                                    </div>
                                    <div class="compare_hint">
                                        После отправки заказа, с вами свяжется менеджер для уточнения деталей.
                                    </div>
                                </div>
                            </div>
                            <!--
                            <div class="row">
                                <div class="delivery">
                                    <?php if( $form_data['need_shipping'] == 1 ): ?>
                                        <input name="need_shipping" type="checkbox" id="2" value="1" checked="checked"/>
                                    <?php else: ?>
                                        <input name="need_shipping" type="checkbox" id="2" value="1" />
                                    <?php endif;?>
                                    <label for="2">Нужна доставка</label>
                                </div>
                                <input type="submit" value="Заказать">
                            </div>
                            -->
                            
                            <!--
                            <div class="row delivery_row" <?php echo ($form_data['need_shipping']==1?"":"style='display:none;'"); ?>>
                                <i class="error">Введите адрес доставки</i>
                                <input  value="<?= $form_data['shipping_address'] ?>" name="shipping_address" type="text" placeholder="Введите адрес"/>                 
                            </div>
                            <p>Нажимая на кнопку Заказать, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                            -->
                        </form>
                    </div>
                </div>
                <div class="cart_description content-text">
                    <?php echo $cart_text;?>
                </div>

            </div>
            
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<?php if(isset($location)):?>
    <div class="modal modal_map">
        <div class="modal-block">
            <div class="modal_overlay"></div>
            <div class="modal-content">
                <div class="modal_close"></div>
                <!--<span><?=$l['name']?></span>-->
                <div class="modal_caption"><?=$location['name']?></div>
                <div class="modal_text_map">
                    <p><?=$location['address']?></p>
                    <p><?=$location['open']?></p>
                    <p><?=$location['comment']?></p>
                    <p>Для вашего удобства можете <a target="_blank" href="<?php echo $location['files'][0]['file_link'];?>">скачать подробную схему проезда</a></p>
                </div>
                <div class="map">
                    <?=trim($location['map'])?>
                </div>
            </div>
        </div>
    </div>
<?php endif;?>
<?= $footer ?>