<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>
        <?php include __DIR__ . '/../partial/breadcrumbs.tpl' ?>
        <h1 class="title">Корзина покупок</h1>
        
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
                    
                    <?php foreach ($totals as $total): ?>
                        <div class="recalc intotal"><?php echo $total['title']; ?>: <span id="total_cart"><?php echo $total['text']; ?></span></div>
                    <?php endforeach; ?>
                    

                    <div class="recalc intotal economy" style="<?php if($ecosum==0){echo 'display:none';}?>" > 
                        Вы сэкономили: <span><span id="ecosum"><?php echo $ecosum;?></span> <div class="rur">i</div></span>
                    </div>
                    <div class="order_weight">Вес заказа: <span><span id="order_weight"><?php echo $total_weight;?></span> кг</span></div>
                    <div class="order_weight">Ориентировочная стоимость доставки: <span><span id="order_weight_cost"><?php echo $total_del;?></span> <div class="rur">i</div></span></div>

                </div>

                <div class="cart_description content-text">
                    <?php echo $cart_text;?>
                </div>
                
                <div class="ordering">
                    <form id="order_form" method="post" enctype="multipart/form-data" >
                        

                        <div class="row">
                            <div class="form-group">
                                <i class="error">Необходимо заполнить</i>
                                <input value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите имя"/>                        
                            </div>

                            <div class="form-group">
                                <i class="error">Необходимо заполнить</i>
                                <input value="<?= $form_data['phone'] ?>" name="phone" type="tel" placeholder="Введите телефон"/>                            
                            </div>

                            <div class="form-group">
                                <i class="error">Неверный формат</i>
                                <input  value="<?= $form_data['email'] ?>" name="email" type="text" placeholder="Введите электронную почту"/>
                            </div>

                            <div class="form-group">
                                <i class="error">Неверный формат</i>
                                <input class="inputInn" value="<?= $form_data['inn'] ?>" name="inn" type="text" placeholder="Введите ИНН"/>
                            </div>
                            <div class="file">
                                <div class="file-block">
                                    <div id="filename">я юрлицо, хочу прикрепить реквизиты</div>
                                    <input id="file" type="file" value="" name="download">
                                </div>
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
                            
                            <input type="submit" value="Заказать">
                        </div>
                        

                        <div class="row delivery_row" <?php echo ($form_data['need_shipping']==1?"":"style='display:none;'"); ?>>
                            <i class="error">Введите адрес доставки</i>
                            <input  value="<?= $form_data['shipping_address'] ?>" name="shipping_address" type="text" placeholder="Введите адрес"/>                 
                        </div>
                        <p>Нажимая на кнопку Заказать, я даю <a target="_blank" href="<?php echo $personaldata;?>">согласие на обработку персональных данных</a></p>
                    </form>
                </div>
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