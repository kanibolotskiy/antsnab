$(window).on('load', function () {
    window.stringForm = {
        tmpl: null,
        templateId: "stringsTmpl",
        insertId: "strings",

        /*INIT*/
        init: function(tmpl){
           this.tmpl = tmpl;
           this.tmpl(this.templateId);
           this.loadData(); 
        },

        loadData: function() {
          var token = $('#token').val(),
                    url = '/admin/index.php?route=extension/module/produnits/getStrings&token=' + token,
                    params = {
                        data: {templateId: $('#templateId').val() },
                        method: 'POST',
                        dataType: 'json',
                        url: url 
                    },
                    self = this;
                $.ajax(params)
                    .done(function(data){
                        if( data.result ) {
                            $.each(data.result, function(index, string){
                                string.error = {};
                                $('#' + self.insertId).append( self.renderRow(string) );
                            });
                            return;
                        }
                        console.warn(data.error);
                    });    
        },

        generate: function() {
            var token = $('#token').val(),
                url = '/admin/index.php?route=extension/module/produnits/generatestrings&token=' + token,
                params = {
                    data: {templateId: $('#templateId').val() },
                    method: 'POST',
                    dataType: 'json',
                    url: url 
                },
                self = this;
            $.ajax(params)
                   .done(function(data){
                        if( data.result ) {
                            self.onGenerate(data.result);
                            return;
                        }
                        console.warn(data.error);
                   });    
        },

        onGenerate: function (strings) {
            var self = this;
            $('#' + self.insertId).html('');
            $.each(strings, function(index, string){
                string.error = {};
                $('#' + self.insertId).append( self.renderRow(string) );
            });
            this.activeSaveButtonState(); 
        },

        /*VIEW*/
        renderRow: function(data) {
            var row = $('<div/>').html( this.tmpl(this.templateId, data )).contents();
            $('input', row).change(this.activeSaveButtonState);
            return row;
        },

        activeSaveButtonState:function () {
           $('#saveStringsBut').prop("disabled", false);    
        },

        inactiveSaveButtonState: function() {
           $('#saveStringsBut').prop("disabled", true);  
        },

        deleteRow: function(el){
           var $row = $(el).parents('tr');
           $row.remove();
           this.activeSaveButtonState();
        },

        addRow: function(){
             $('#' + this.insertId).append( this.renderRow({error:{}}) );
        },

        /*CRUD*/
        saveAll: function(){
            var saveData = [];

            $('#strings > tr').each(function(index){
                var $row = $(this),
                    obj = {
                        description: $('input[data-name="description"]', $row).val(),
                        value:  $('input[data-name="value"]', $row).val(), 
                        sortOrder:  $('input[data-name="sortOrder"]', $row).val() 
                    };
                saveData.push(obj); 
            });

            var token = $('#token').val(),
                url = '/admin/index.php?route=extension/module/produnits/saveAll&token=' + token,
                params = {
                    data: {templateId: $('#templateId').val(), data: saveData },
                    method: 'POST',
                    dataType: 'json',
                    url: url 
                },
                self = this;
            $.ajax(params)
                   .done(function(data){
                        if( data.result ) {
                            self.inactiveSaveButtonState();
                            return;
                        }
                        console.warn(data.error);
                   });     
        }

        
    },

    window.unitForm = {
            tmpl: null,
            loaded: {},
            templateId: "unit_rows",
            insertId: "unitBody",
            
            /*INIT*/
            init: function (tmpl) {
                this.tmpl = tmpl;
                this.tmpl(this.templateId);
                $('[data-baseselect]').on('change', this.onBaseChange);
                this.loadData();
            },

            loadData: function () {
                var token = $('#token').val(),
                    url = '/admin/index.php?route=extension/module/produnits/getUnits&token=' + token,
                    params = {
                        data: {templateId: $('#templateId').val() },
                        method: 'POST',
                        dataType: 'json',
                        url: url 
                    },
                    self = this;
                $.ajax(params)
                    .done(function(data){
                        if( data.result ) {
                            self.onLoad(data.result);
                            return;
                        }
                        console.warn(data.error);
                    });
            },

            onLoad: function(units) {
                var self = this;

                self.loaded = {};
                $.each(units, function(index, unit){
                    unit.error = {};
                    self.loaded['el'+unit.id] = unit;
                    $('#' + self.insertId).append( self.renderRow(unit) );
                });
                this.redrawSelects();
            },

            /*Getters*/
            getLoaded: function() {
                return this.loaded;
            },

            getLoadedRow: function(id) {
                return this.loaded['el' + id];   
            },

            /*CRUD*/
            addRow: function() {
                var row = this.renderRow( {error:{}} ); 
                $('.saveBut', row).prop("disabled", false);

                $('#' + this.insertId).append( row );
                this.redrawSelects();
            },

            saveRow: function (el) {
                var id = $(el).attr('data-id'),
                    token = $('#token').val(),
                    row = $(el).parents('tr'),
                    rowData = {
                                id:id,
                                templateId: $('#templateId').val(),
                                name: $('input[data-name="name"]', row).val(),
                                calcKoef: $('input[data-name="calcKoef"]', row).val(),
                                calcRel: $('select[data-name="calcRel"]', row).val(),
                                switchSortOrder: $('input[data-name="switchSortOrder"]', row).val(),
                                name_price: $('input[data-name="name_price"]', row).val(),
                                loadingSortOrder: $('input[data-name="loadingSortOrder"]', row).val(),
                                weight: $('input[data-name="weight"]', row).val(),
                                name_plural: $('input[data-name="name_plural"]', row).val(),
                                name_package_dimension: $('input[data-name="name_package_dimension"]', row).val(),
                                name_in_package: $('input[data-name="name_in_package"]', row).val(),
                                package_width: $('input[data-name="package_width"]', row).val(),
                                package_length: $('input[data-name="package_length"]', row).val(),
                                package_height: $('input[data-name="package_height"]', row).val()
                              }, 
                    url = '/admin/index.php?route=extension/module/produnits/saveunit&token=' + token,
                    params = {
                        data: rowData,
                        method: 'POST',
                        dataType: 'json',
                        url: url 
                    },
                    self = this;
                $.ajax(params)
                    .done(function(data){
                        rowData.error = {};
                        if( data.error ) {
                            rowData.error = data.error; 
                        }

                        if( data.result ) {
                            rowData.id = parseInt(data.result);
                            self.loaded['el'+rowData.id] = rowData;
                        }

                        row.replaceWith( self.renderRow(rowData) );
                        self.redrawSelects();
                        console.log('request done' + rowData.id);
                    });
            },

            deleteRow: function (el) {
               if( !confirm('Вы уверены?') ) {
                   return;
               }
    
               var id = $(el).attr('data-id'),
                   token = $('#token').val(),
                   row = $(el).parents('tr'),
                   self = this;

               if ( id === 'new' ) {
                   row.remove();
                   return;
               }

               $.ajax({
                    url:'/admin/index.php?route=extension/module/produnits/deleteunit&token=' + token, 
                    data: {id:parseInt(id)},
                    dataType: 'json',
                    method: 'POST' 
               })
                   .done(function(data){
                       if( data.result ) {
                           delete self.loaded['el' + id]; 
                           row.remove();
                           self.redrawSelects();
                           return;
                       }
                       console.warn(data.error);
                   });
            },
            
            /*VIEW*/
            renderRow: function(unit) {
                var row = $('<div/>').html( this.tmpl(this.templateId, unit )).contents();
                $('input', row).change(this.onRowChange);
                $('select', row).change(this.onRowChange);
                return row;
            },

            onRowChange(){
                var $el = $(this),
                    row = $el.parents('tr');
                $('.saveBut', row).prop("disabled", false);
            },

            redrawSelects: function () {
                //redraw row and base selects 
                var self = this,
                    selects = $('[data-relselect], [data-baseselect]');
                selects.each(function(index){
                    var select = $(this), 
                        val = parseInt( select.attr('data-val') ),
                        defoption = $('option', select)[0],
                        defoptionVal = $(defoption).attr('value'),
                        defoptionLbl = $(defoption).text();
                        
                    select.html('');
                    select.append('<option value="'+defoptionVal+'">'+defoptionLbl+'</option>');
                    $.each(self.loaded, function(key, unit) {
                        if( unit.id == val ) {
                            select.append('<option selected value="' + unit.id +'">' + unit.name +'</option>');
                        } else {
                            select.append('<option value="' + unit.id +'">' + unit.name +'</option>');
                        }
                    });
                });
            },

            onBaseChange:function() {
                var $el = $(this),
                    name = $el.attr('data-name'),
                    val = $el.val(),
                    token = $('#token').val();
                $.ajax({
                    url:'/admin/index.php?route=extension/module/produnits/changebase&token=' + token, 
                    data: {name:name, value:val, template_id: $('#templateId').val() },
                    dataType: 'json',
                    method: 'POST' 
                })
                 .done(function(data){
                    if( data.result ) {
                        $el.attr('data-val', val);
                        $('#baseError').hide();
                        return;
                    } else {
                        $('#baseError').html(data.error[0]);
                        $('#baseError').show();
                        $el.val( $el.attr('data-val') );
                    }
                    console.warn(data.error); 
                });
            }
        };
        
        if( typeof(window.tmpl) === 'function' ) {
            unitForm.init(window.tmpl);
            stringForm.init(window.tmpl);
        }

    
});

