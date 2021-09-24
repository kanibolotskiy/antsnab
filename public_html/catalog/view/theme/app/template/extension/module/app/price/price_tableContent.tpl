 <?php foreach ($categories as $categoryId => $catData): ?>
    <tr>
        <td colspan="4" class="text-row">
            <h2><a href="<?=$catData['href']?>"><?=$catData['name']?></a></h2>
        </td>
    </tr>
        <?php foreach ($catData['products'] as $prodData) :  ?>
        <?php if(!$prodData['notavail']){?>       
            <tr>
                <td>
                    <a href="<?=$prodData['href']?>" class="no-formated">
                        <?=html_entity_decode($prodData['name'])?>
                    </a>
                </td>
                <td class="hide_on_mobile sec_column_price">
                    <?php
                        $package = '';
                        if( isset($saleUnits[$prodData['product_id']]) ){
                            $saleUnit = $saleUnits[$prodData['product_id']];
                            $package = $saleUnit['name'];
                            if( isset($saleUnit['calcKoef']) && isset($saleUnit['to_name_plural']) ){
                                $packageStr = \WS\Override\Gateway\ProdUnits\ProdUnitStrings::packageString(
                                    $saleUnit['calcKoef'],
                                    [
                                        'pluralGenitive' => $saleUnit['to_name_plural'],
                                        'single' => $saleUnit['to_name'],
                                        'genitive' => $saleUnit['to_name_genitive']??null
                                    ]
                                );
                                $package .= ', ' . $packageStr;
                            }
                        }
                    ?>
                    <?=$package?>
                </td>

                <?php if(isset($priceUnits[$prodData['product_id']])):?>
                <?php $currencyPerUnit = '/' . $priceUnits[$prodData['product_id']]['name_price']?> 
                <?php else:?>
                <?php $currencyPerUnit = ''; ?>
                <?php endif;?>

                <td class="column-price column-price-1" style="display: table-cell;">
                    <!--<?= $cur->format($prodData['price'], $curSym) . $currencyPerUnit;?>-->
                    <?= number_format($prodData['price'],0,".", " ") . " ₽" . $currencyPerUnit;?>
                </td>
                <td class="column-price column-price-1" style="display: table-cell;">
                    <!--<?= $cur->format($prodData['price_wholesale'], $curSym) . $currencyPerUnit?>-->
                    <?= number_format($prodData['price_wholesale'],0,".", " ") . " ₽" . $currencyPerUnit;?>

                </td>
                <td class="column-price column-price-2" style="display: none;">
                    <?= $cur->format($prodData['price'], $curSym) . $currencyPerUnit?>
                </td>
                <td class="column-price column-price-2" style="display: none;">
                    <?= $cur->format($prodData['price_wholesale'], $curSym) . $currencyPerUnit?>
                </td>

            </tr>
        <?php }?>
        <?php endforeach; ?>
<?php endforeach;?>
