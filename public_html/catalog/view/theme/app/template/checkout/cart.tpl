<?= $header ?>
<div class="container main">
    <?= $column_left ?>
    <div class="content">
        <?php echo $content_top; ?>

        <div class="basket-container">
            <div class="title">
                Корзина
            </div>
            <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
                <div class="basket-block">
                    <?php foreach ($products as $product) { ?> 
                        <div class="basket-row">
                            <ul>
                                <li>
                                    <?php if ($product['thumb']) { ?>
                                        <a target="_blank" href="<?php echo $product['href']; ?>">
                                            <img src="<?php echo $product['thumb']; ?>" 
                                                 alt="<?php echo $product['name']; ?>" 
                                                 title="<?php echo $product['name']; ?>" 
                                                 class="img-thumbnail" />
                                        </a>
                                    <?php } ?>
                                </li>
                                <li>
                                    <a class="prod-name" href="<?php echo $product['href']; ?>">
                                        <?php echo $product['name']; ?>
                                    </a>
                                    <p>Для гидроизоляционных,
                                        обмазочных и кровельных работ.</p>
                                </li>
                                <li>
                                    <?php if ($product['quantity'] >= $product['wholesale_threshold']): ?>
                                        <span>Цена опт</span>
                                        <strong><?= $product['price_wholesale']; ?></strong>
                                    <?php else: ?>
                                        <span>Цена розн.</span>
                                        <strong><?= $product['price']; ?></strong>
                                    <?php endif; ?>
                                </li>
                                <li>
                                    <div class="OutputContainer">
                                        <input 
                                            data-factInterval="<?= $step ?>" 
                                            data-visualInterval="<?= $step ?>"
                                            data-name="<?= $priceUnit ?>"
                                            class="spinner" 
                                            type="text"  
                                            name="quantity[<?php echo $product['cart_id']; ?>]" 
                                            value="<?php echo $product['quantity']; ?>"/>
                                    </div>
                                </li>
                                <li>
                                    <span>Сумма</span>
                                    <strong class="recalc"><?php echo $product['total']; ?></strong>
                                </li>
                                <li>
                                    <a href="#" 
                                       title="<?php echo $button_remove; ?>"
                                       data-cartid="<?php echo $product['cart_id']; ?>"
                                       class="actionbut delete">
                                        <i class="fa fa-close fa-xs"></i>
                                    </a>
                                    <a href="#" 
                                       title="<?php echo $button_update; ?>"
                                       data-cartid="<?php echo $product['cart_id']; ?>"
                                       class="actionbut reload">
                                        <i class="fa fa-repeat fa-xs"></i>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    <?php } ?>
                </div>
            </form>
            <?php //@task to css ?>
            <!--<a style="float:right; margin-bottom:18px" href="<?= $action ?>" class="buy">Пересчитать</a>
            <div style="clear:both"></div>-->            
            <?php foreach ($totals as $total): ?>
                <strong class="recalc intotal"><?php echo $total['title']; ?>: <?php echo $total['text']; ?></strong>
            <?php endforeach; ?>
            <div class="ordering">
                <form id="order_form" method="post" enctype="multipart/form-data" >
                    <p>Нажимая на кнопку Заказать, я даю <a target="_blank" href="index.php?route=information/information&information_id=3">согласие на обработку персональных данных</a></p>
                    <div class="row">
                        <div class="form-group">
                            <?php if (isset($form_errors['name'])): ?>
                                <i class="error"><?= $form_errors['name'] ?></i>
                                <input value="<?= $form_data['name'] ?>" class="error" name="name" type="text" placeholder="Введите имя"/>
                            <?php else: ?>    
                                <input  value="<?= $form_data['name'] ?>" name="name" type="text" placeholder="Введите имя"/>
                            <?php endif; ?>
                        </div>

                        <div class="form-group">
                            <?php if (isset($form_errors['phone'])): ?>
                                <i class="error"><?= $form_errors['phone'] ?></i>
                                <input value="<?= $form_data['phone'] ?>" class="error" name="phone" type="text" placeholder="Введите телефон"/>
                            <?php else: ?>    
                                <input  value="<?= $form_data['phone'] ?>" name="phone" type="text" placeholder="Введите телефон"/>
                            <?php endif; ?>
                        </div>

                        <div class="form-group">
                            <?php if (isset($form_errors['email'])): ?>
                                <i class="error"><?= $form_errors['email'] ?></i>
                                <input value="<?= $form_data['email'] ?>" class="error" name="email" type="text" placeholder="Введите электронную почту"/>
                            <?php else: ?>    
                                <input  value="<?= $form_data['email'] ?>" name="email" type="text" placeholder="Введите электронную почту"/>
                            <?php endif; ?>
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
                                <div id="filename">Я Юр. лицо, хочу
                                    прикрепить реквизиты</div>
                                <input id="file" type="file" value="">
                            </div>
                        </div>
                        <input type="submit" value="Заказать">
                    </div>
                    <div class="row">
                        <?php if (isset($form_errors['shipping_address'])): ?>
                            <i class="error"><?= $form_errors['shipping_address'] ?></i>
                            <input value="<?= $form_data['shipping_address'] ?>" class="error" name="shipping_address" type="text" placeholder="Введите адрес"/>
                        <?php else: ?>    
                            <input  value="<?= $form_data['shipping_address'] ?>" name="shipping_address" type="text" placeholder="Введите адрес"/>
                        <?php endif; ?>
                    </div>
                </form>
            </div>
        </div>
        <!--
        <div class="mentioned-products mentioned-products2">
            <div class="title">Сопутствующие товары</div>
            <ul>
                <li>
                    <div class="products-block">
                        <div class="img-production">
                            <img src="img/img53.jpg" alt="img">
                        </div>
                        <a href="" class="title-product">Мастика Битумная
                            Универсальная</a>
                        <strong>1 350 р. </strong>
                        <a href="" class="order-btn">Купить</a>
                    </div>
                </li>
                <li>
                    <div class="products-block">
                        <div class="img-production">
                            <img src="img/img54.jpg" alt="img">
                        </div>
                        <a href="" class="title-product">Гермобутилкаучук
                            НАНО</a>
                        <strong>1 350 р. </strong>
                        <a href="" class="order-btn">Купить</a>
                    </div>
                </li>
                <li>
                    <div class="products-block">
                        <div class="img-production">
                            <img src="img/img55.jpg" alt="img">
                        </div>
                        <a href="" class="title-product">Битумный праймер
                            КРЗ</a>
                        <strong>1 350 р. </strong>
                        <a href="" class="order-btn">Купить</a>
                    </div>
                </li>
                <li>
                    <div class="products-block">
                        <div class="img-production">
                            <img src="img/img56.jpg" alt="img">
                        </div>
                        <a href="" class="title-product">Грунтовка
                            уневерсальная</a>
                        <strong>1 350 р. </strong>
                        <a href="" class="order-btn">Купить</a>
                    </div>
                </li>
            </ul>
        </div>-->

        <?php echo $content_bottom; ?>
    </div>
</div>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        $('.spinner').SpinnerControl();
        /*$('.spinner').on('spinnerMinus spinnerPlus', function() {
         $('.recalc').html('--');
         });*/
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