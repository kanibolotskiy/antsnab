 <?php foreach ($categories as $categoryId => $catData): ?>
    <tr>
        <td colspan="4" class="text-row">
            <h3><a href="<?=$catData['href']?>"><?=$catData['name']?></a></h3>
        </td>
    </tr>
        <?php foreach ($catData['products'] as $prodData) :  ?>
        <tr>
            <td>
                <a href="<?=$prodData['href']?>" class="no-formated">
                    <?=$prodData['meta_h1']?>
                </a>
            </td>
            <td class="hide_on_mobile">
                <?php if(isset($saleUnits[$prodData['product_id']])):?>
                    <?php $package = $saleUnits[$prodData['product_id']]['name'] . ', '
                                   . number_format($saleUnits[$prodData['product_id']]['calcKoef'], 0, ',', ' ')
                                   . $saleUnits[$prodData['product_id']]['to_name_plural'];
                    ?>
                <?php else: ?>
                    <?php $package = '' ?>;
                <?php endif;?>
                <?=$package?>
            </td>

            <?php if(isset($priceUnits[$prodData['product_id']])):?>
               <?php $currencyPerUnit = '/' . $priceUnits[$prodData['product_id']]['name_price']?> 
            <?php else:?>
               <?php $currencyPerUnit = ''; ?>
            <?php endif;?>

            <td class="column-price column-price-1" style="display: table-cell;">
                <?= $cur->format($prodData['price'], $curSym) . $currencyPerUnit;?>
            </td>
            <td class="column-price column-price-1" style="display: table-cell;">
                <?= $cur->format($prodData['price_wholesale'], $curSym) . $currencyPerUnit?>
            </td>
            <td class="column-price column-price-2" style="display: none;">
                <?= $cur->format($prodData['price'], $curSym) . $currencyPerUnit?>
            </td>
            <td class="column-price column-price-2" style="display: none;">
                <?= $cur->format($prodData['price_wholesale'], $curSym) . $currencyPerUnit?>
            </td>

        </tr>
        <?php endforeach; ?>
<?php endforeach;?>
