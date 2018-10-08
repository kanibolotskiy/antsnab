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
                <tbody id="priceTableContent">
                <?=$priceTableContent?>
                </tbody>
            </table>
            
        </div>
</div>

<script>
   document.addEventListener("DOMContentLoaded", function(){
      function redrawSelector(id, options, currentValue) {
              var $container = $('#' + id),
                  $jcf = $('.select-area', $container),
                  $selector = $container.find('select');
              $selector.remove();
              $selector = $(document.createElement('select'));
              $selector.addClass('catSelector');
              $.each(options, function(text, val) {
                var $option = $(document.createElement('option'));
                    $option.attr('value', val);
                    $option.text(text);
                    $selector.append($option);    
              });
              $selector.val(currentValue);
              $jcf.remove();
              $container.append($selector);
              jcf.customForms.replaceAll(); 
      }

       function redrawBreadcrumbs(){
            var $breadcrumbs = $('.dop-title'),
                       string = $('#firstActive > select > option:selected').text(); 

                   if( "<?=$SHOW_ALL_OPTION_VALUE?>" !== $('#secondActive > select').val() ) {
                       string += ' > ' + $('#secondActive > select > option:selected').text(); 
                   } 

                   if( undefined !== $('#thirdActive > select').val() &&
                       "<?=$SHOW_ALL_OPTION_VALUE?>" !== $('#thirdActive > select').val() ) {

                       string += ' > ' + $('#thirdActive > select > option:selected').text(); 
                   }

                   $breadcrumbs.text(string);     
       }

       redrawBreadcrumbs();

       $('body').delegate('.catSelector', 'change', function(){
           var postData = {
                firstActive: $('#firstActive > select').val()    
           };

           var changedId = $(this).parent('li').attr('id'); 
           
           if( "<?=$SHOW_ALL_OPTION_VALUE?>" !== $('#secondActive > select').val() && 
               changedId !== 'firstActive' 
             ) {
               postData.secondActive = $('#secondActive > select').val();
           }

           if( undefined !== $('#thirdActive > select').val() 
                   && "<?=$SHOW_ALL_OPTION_VALUE?>" !== $('#thirdActive > select').val()
                   && changedId !=='secondActive'
                   && changedId !=='firstActive' ) {
               postData.thirdActive = $('#thirdActive > select ').val();
           }

           $.ajax({
               url: 'index.php?route=product/price/ajaxRefresh',
               method: 'POST',
               data: postData,
               dataType: 'json',
               error: function(){
                   alert('Error while request');
               },
               success: function(data) {
                   console.warn(data);
                   
                   //Selectors
                   var firstActive = data.selectors.active[0];
                   redrawSelector('firstActive', data.selectors.l1, firstActive);

                   var secondActive = data.selectors.active[1] || "<?=$SHOW_ALL_OPTION_VALUE?>";
                   redrawSelector('secondActive', data.selectors.l2, secondActive);

                   if( undefined === data.selectors.l3 ) {
                        $('#thirdActive > select').remove();
                        $('#thirdActive > .select-area').remove();
                        $('#thirdActive').css("visibility", "hidden"); 
                   } else {
                       var thirdActive = data.selectors.active[2] || "<?=$SHOW_ALL_OPTION_VALUE?>";
                       redrawSelector('thirdActive', data.selectors.l3, thirdActive);
                       $('#thirdActive').css("visibility", "visible");
                   }

                   //Breadcrumbs
                   redrawBreadcrumbs();

                   //Table
                   $('#priceTableContent').html(data.table);
                   
               }
           });
       }); 
   }); 
</script>