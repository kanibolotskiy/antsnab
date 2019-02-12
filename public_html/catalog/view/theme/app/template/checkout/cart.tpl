<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <div class="title">
            Корзина покупок
        </div>
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

                <?php foreach ($totals as $total): ?>
                    <strong class="recalc intotal"><?php echo $total['title']; ?>: <span id="total_cart"><?php echo $total['text']; ?></span></strong>
                <?php endforeach; ?>

                <div class="ordering">
                    <form id="order_form" method="post" enctype="multipart/form-data" >
                        <p>Нажимая на кнопку Заказать, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>

                        <div class="row">
                            <div class="form-group">
                                <i class="error">Необходимо заполнить</i>
                                <input value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите имя"/>                        
                            </div>

                            <div class="form-group">
                                <i class="error">Необходимо заполнить</i>
                                <input value="<?= $form_data['phone'] ?>" name="phone" type="text" placeholder="Введите телефон"/>                            
                            </div>

                            <div class="form-group">
                                <i class="error">Неверный формат</i>
                                <input  value="<?= $form_data['email'] ?>" name="email" type="text" placeholder="Введите электронную почту"/>
                            </div>

                        </div>
                        <div class="row">

                            <div class="delivery">
                                <?php if( $form_data['need_shipping'] == 1 ): ?>
                                    <input name="need_shipping" type="checkbox" id="2" value="1" checked="checked"/>
                                <?php else: ?>
                                    <input name="need_shipping" type="checkbox" id="2" value="1" />
                                <?php endif;?>
                                <label for="2">Нужна доставка</label>
                            </div>
                            <div class="file">
                                <div class="file-block">
                                    <div id="filename">я юрлицо, хочу прикрепить реквизиты</div>
                                    <input id="file" type="file" value="" name="download">
                                </div>
                            </div>
                            <input type="submit" value="Заказать">
                        </div>
                        

                        <div class="row delivery_row" <?php echo ($form_data['need_shipping']==1?"":"style='display:none;'"); ?>>
                            <i class="error">Введите адрес доставки</i>
                            <input  value="<?= $form_data['shipping_address'] ?>" name="shipping_address" type="text" placeholder="Введите адрес"/>                 
                        </div>
                    </form>
                </div>
            </div>
            <div class="cart_description">
                <?php echo $cart_text;?>
            </div>

            
            <div class="mentioned-products mentioned-products2">
                <?php if( $products_analog):?>
                <div class="title">Сопутствующие товары</div>
                <ul>
                
                    <?php foreach( $products_analog as $p):?>
                    
                    <li>
                        <div class="products-block">
                            <a href="<?=$p['href']?>" class="img-production">
                                <img src="<?=$p['thumb']?>" alt="<?=$p['name']?>" title="<?=$p['name']?>">
                            </a>
                            <a href="<?=$p['href']?>" class="title-product"><?=$p['name']?></a>
                            <strong><?=$p['price']?></strong>
                            
                            <div class="quantity-buy cart_quantity-buy">
                                <?php if(empty($p['unit_errors'])): ?>
                                    <div class="qnt-container"
                                        data-sale_to_ui_koef="<?=$p['sale_to_ui_koef']?>"
                                        data-ui_name="<?=$p['ui_unit_name']?>"
                                        data-ui_name_plural="<?=$p['ui_unit_name_plural']?>"
                                        data-ui_name_genitive="<?=$p['ui_unit_name_genitive']?>"
                                        <?php if($p['ui_unit_force_step_by_one'] == 1):?>
                                        data-ui_minimum="1"
                                        data-ui_step= 1"
                                        <?php endif; ?>
                                    >
                                    </div>
                                    <a href="#" class="buy cart_button_buy"
                                        data-product_id="<?=$p['product_id']?>" 
                                        data-sale_to_price_koef="<?=$p['sale_to_price_koef']?>">
                                        Купить
                                    </a>
                                <?php else: ?>
                                    <?php foreach($p['unit_errors'] as $e): ?>
                                        <?=$e . "<br/>"?>
                                    <?php endforeach; ?>
                                <?php endif;?>
                            </div>
                            
                            
                        </div>
                        
                    </li>
                    <?php endforeach;?>
                </ul>
                <?php endif;?>
            </div>
        </div>
        <?php echo $content_bottom; ?>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        $('.delete').on('click', function (e) {
            e.preventDefault();
            cart.remove($(this).attr('data-cartid'));
        });
        $('.reload').on('click', function (e) {
            e.preventDefault();
            $(this).parents('form').submit();
        });
        $('#file').on('change', function () {
            var filename = this.files[0].name;
            $('#filename').html(filename);
        });
    });
</script>
<?= $footer ?>