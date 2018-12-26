<div class="price-list">
        <div class="download download3">
                <span><?=$price_download?></span>
            <ul>
                <li>
                    <a target="_blank" href="<?=$pdf?>" title="Прайс pdf"></a>
                </li>
                <li>
                    <a target="_blank" href="<?=$xls?>" title="Прайс xlsx"></a>
                </li>
            </ul>
        </div>
        <div class="select-list">
            <ul>
                <li id="firstActive">
                    <strong><?=$select_category_text?></strong>
                    <select class="catSelector" >
                        <?php if( !empty($selectors['l1']) ):?>
                            <?php foreach($selectors['l1'] as $catName  => $catId ):?>
                                <?php if( $catId == $selectors['active'][0] ):?>
                                <option selected="selected" value="<?=$catId?>"><?=$catName?></option>
                                <?php else: ?>
                                <option value="<?=$catId?>"><?=$catName?></option>
                                <?php endif;?>
                            <?php endforeach;?>
                        <?php endif;?>
                    </select>
                </li>
                <li id="secondActive">
                    <strong><?=$select_subcategory_text?></strong>
                    <select  class="catSelector" >
                        <?php if( !empty($selectors['l2']) ):?>
                            <?php foreach($selectors['l2'] as $catName  => $catId ):?>
                                <?php if( isset($selectors['active'][1]) && $catId == $selectors['active'][1] ):?>
                                <option selected="selected" value="<?=$catId?>"><?=$catName?></option>
                                <?php else: ?>
                                <option value="<?=$catId?>"><?=$catName?></option>
                                <?php endif;?>
                            <?php endforeach;?>
                        <?php endif;?>
                    </select>
                </li>
                <?php if( empty($selectors['l3']) ):?>
                <li id="thirdActive" style="visibility:hidden">
                    <strong><?=$select_product_text?></strong>
                </li>
                <?php else: ?>
                <li id="thirdActive">
                    <strong><?=$select_product_text?></strong>
                    <select  class="catSelector" >
                        <?php if( !empty($selectors['l3']) ):?>
                            <?php foreach($selectors['l3'] as $catName  => $catId ):?>
                                <?php if( isset($selectors['active'][2]) && $catId == $selectors['active'][2] ):?>
                                <option selected="selected" value="<?=$catId?>"><?=$catName?></option>
                                <?php else: ?>
                                <option value="<?=$catId?>"><?=$catName?></option>
                                <?php endif;?>
                            <?php endforeach;?>
                        <?php endif;?>
                    </select>
                </li>
                <?php endif;?>
            </ul>
        </div>
        <div class="dop-title"></div>
        <div class="table table4">
            <table>
                <thead>
                <tr>
                    <th><?=$product_text?></th>
                    <th class="hide_on_mobile_"><?=$package_text?></th>
                    <th class="column-price column-price-1" style="display: table-cell;"><?=$price_text?></th>
                    <th class="column-price column-price-1" style="display: table-cell;"><?=$price_wholesale_text?></th>
                </tr>
                </thead>
                <tbody id="priceTableContent" data-show_all_option_value="<?=$SHOW_ALL_OPTION_VALUE?>">
                <?=$priceTableContent?>
                </tbody>
            </table>
        </div>
</div>