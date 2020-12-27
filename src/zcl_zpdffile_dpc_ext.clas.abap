class ZCL_ZPDFFILE_DPC_EXT definition
  public
  inheriting from ZCL_ZPDFFILE_DPC
  create public .

public section.
protected section.

  methods PDFANNOTATIONSET_CREATE_ENTITY
    redefinition .
  methods PDFANNOTATIONSET_DELETE_ENTITY
    redefinition .
  methods PDFANNOTATIONSET_GET_ENTITY
    redefinition .
  methods PDFANNOTATIONSET_GET_ENTITYSET
    redefinition .
  methods PDFANNOTATIONSET_UPDATE_ENTITY
    redefinition .
  methods PDFFILESET_CREATE_ENTITY
    redefinition .
  methods PDFFILESET_DELETE_ENTITY
    redefinition .
  methods PDFFILESET_GET_ENTITY
    redefinition .
  methods PDFFILESET_GET_ENTITYSET
    redefinition .
  methods PDFFILESET_UPDATE_ENTITY
    redefinition .
  methods PDFFORMFIELDSET_CREATE_ENTITY
    redefinition .
  methods PDFFORMFIELDSET_GET_ENTITY
    redefinition .
  methods PDFFORMFIELDSET_GET_ENTITYSET
    redefinition .
  methods PDFFORMFIELDSET_UPDATE_ENTITY
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZPDFFILE_DPC_EXT IMPLEMENTATION.


  method PDFANNOTATIONSET_CREATE_ENTITY.
    data ls_entity type zpdf_annotation.

    io_data_provider->read_entry_data( importing es_data = ls_entity ).

    er_entity = zcl_pdf_annotation_dao=>get_instance( )->create_entity( ls_entity ).

  endmethod.


  method PDFANNOTATIONSET_DELETE_ENTITY.

    data ls_entity type zpdf_annotation.
*-- mapping the input data
    io_tech_request_context->get_converted_keys( importing es_key_values =  ls_entity ).

*-- deleting the file
    zcl_pdf_annotation_dao=>get_instance( )->delete_entity( iv_id = ls_entity-id
                                                            iv_annotation_id = ls_entity-annotation_id ).

  endmethod.


  method PDFANNOTATIONSET_GET_ENTITY.
*-- mapping the data
    io_tech_request_context->get_converted_keys( importing es_key_values =  er_entity ).

*-- reading the data
    er_entity = zcl_pdf_annotation_dao=>get_instance( )->get_entity( iv_id    = er_entity-id
                                                                     iv_annotation_id = er_entity-annotation_id ).
  endmethod.


  method PDFANNOTATIONSET_GET_ENTITYSET.
    data ls_entity like line of et_entityset.

    io_tech_request_context->get_converted_source_keys( importing es_key_values =  ls_entity ).

    data(lv_where_clause) = io_tech_request_context->get_osql_where_clause( ).

    et_entityset = zcl_pdf_annotation_dao=>get_instance( )->get_entity_set( iv_id = ls_entity-id
                                                                            iv_where_clause = lv_where_clause ).

    describe table et_entityset lines es_response_context-inlinecount.

  endmethod.


  method PDFANNOTATIONSET_UPDATE_ENTITY.

    data ls_entity type zpdf_annotation.

    io_data_provider->read_entry_data( importing es_data = ls_entity ).

    er_entity = zcl_pdf_annotation_dao=>get_instance( )->update_entity( ls_entity ).

  endmethod.


  method pdffileset_create_entity.
    data ls_entity type zpdf_file.
*-- mapping the input data
    io_data_provider->read_entry_data( importing es_data = ls_entity ).

*-- creating the entity
    er_entity = zcl_pdf_file_dao=>get_instance( )->create_entity( ls_entity ).

  endmethod.


  method PDFFILESET_DELETE_ENTITY.

    data ls_entity type zpdf_file.
*-- mapping the input data
    io_tech_request_context->get_converted_keys( importing es_key_values =  ls_entity ).

*-- deleting the file
    zcl_pdf_file_dao=>get_instance( )->delete_entity( iv_id = ls_entity-id ).
  endmethod.


  method PDFFILESET_GET_ENTITY.
*-- mapping the data
    io_tech_request_context->get_converted_keys( importing es_key_values =  er_entity ).

*-- reading the data
    er_entity = zcl_pdf_file_dao=>get_instance( )->get_entity( iv_id = er_entity-id ).
  endmethod.


  method PDFFILESET_GET_ENTITYSET.
    data(lv_sql_where_clause) = io_tech_request_context->get_osql_where_clause( ).
    et_entityset = zcl_pdf_file_dao=>get_instance( )->get_entity_set( lv_sql_where_clause ).

    describe table et_entityset lines es_response_context-inlinecount.
  endmethod.


  method PDFFILESET_UPDATE_ENTITY.
     data ls_entity type zpdf_file.
*-- mapping the input data
    io_data_provider->read_entry_data( importing es_data = ls_entity ).

*-- creating the entity
    er_entity = zcl_pdf_file_dao=>get_instance( )->update_entity( ls_entity ).
  endmethod.


  method PDFFORMFIELDSET_CREATE_ENTITY.
    data ls_entity like er_entity.

    io_data_provider->read_entry_data( importing es_data = ls_entity ).

    er_entity = zcl_pdf_form_field_dao=>get_instance( )->create_entity( ls_entity ).

  endmethod.


  method PDFFORMFIELDSET_GET_ENTITY.
*-- mapping the data
    io_tech_request_context->get_converted_keys( importing es_key_values =  er_entity ).

*-- reading the data
    er_entity = zcl_pdf_form_field_dao=>get_instance( )->get_entity( iv_id   = er_entity-id
                                                                     iv_name = er_entity-name ).
  endmethod.


  method pdfformfieldset_get_entityset.

    data ls_entity like line of et_entityset.

    io_tech_request_context->get_converted_source_keys( importing es_key_values =  ls_entity ).

    data(lv_sql_where_clause) = io_tech_request_context->get_osql_where_clause( ).

    et_entityset = zcl_pdf_form_field_dao=>get_instance( )->get_entity_set( iv_id = ls_entity-id
                                                                            iv_where_clause = lv_sql_where_clause ).

  endmethod.


  method PDFFORMFIELDSET_UPDATE_ENTITY.
    data ls_entity like er_entity.

    io_data_provider->read_entry_data( importing es_data = ls_entity ).

    er_entity = zcl_pdf_form_field_dao=>get_instance( )->update_entity( ls_entity ).
  endmethod.
ENDCLASS.
