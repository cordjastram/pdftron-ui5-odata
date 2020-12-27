class ZCL_PDF_FORM_FIELD_DAO definition
  public
  final
  create public .

public section.

  methods GET_ENTITY_SET
    importing
      !IV_ID type Z_FILE_ID
      !IV_WHERE_CLAUSE type STRING
    returning
      value(RETURN) type ZPDF_FORM_FIELD_TT .
  methods CREATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_FORM_FIELD
    returning
      value(RETURN) type ZPDF_FORM_FIELD .
  methods UPDATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_FORM_FIELD
    returning
      value(RETURN) type ZPDF_FORM_FIELD .
  methods DELETE_ENTITY
    importing
      !IS_ENTITY type ZPDF_FORM_FIELD .
  methods DELETE_ENTITIES
    importing
      !IV_ID type Z_FILE_ID .
  class-methods GET_INSTANCE
    returning
      value(RETURN) type ref to ZCL_PDF_FORM_FIELD_DAO .
  methods GET_ENTITY
    importing
      !IV_ID type SYSUUID_X
      !IV_NAME type Z_FORM_FIELD_NAME
    returning
      value(RETURN) type ZPDF_FORM_FIELD .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PDF_FORM_FIELD_DAO IMPLEMENTATION.


  method create_entity.
    return = is_entity.

    check return-id is not initial.

    return-created_by = sy-uname.
    return-changed_by = sy-uname.
    get time stamp field return-created_at.
    return-changed_at = return-created_at.

    insert zpdf_form_field from return.

  endmethod.


  method DELETE_ENTITIES.

    delete from zpdf_form_field
      where id = iv_id.

  endmethod.


  method DELETE_ENTITY.

    delete zpdf_form_field from is_entity.

  endmethod.


  method get_entity.
    check iv_id is not initial.
    check iv_name is not initial.

    select single * from zpdf_form_field into return
        where
          id = iv_id and
          name = iv_name.

  endmethod.


  method GET_ENTITY_SET.

    select * from zpdf_form_field into corresponding fields of table return
      where id = iv_id and (iv_where_clause) order by name.

  endmethod.


  method GET_INSTANCE.

    create object return.

  endmethod.


  method update_entity.
    return = is_entity.

    check return-id is not initial.

    select single * from zpdf_form_field into
      return where id = is_entity-id and
                   name = is_entity-name.

    check sy-subrc = 0.

    if is_entity-value ne return-value.
      return-changed_by = sy-uname.
      return-value = is_entity-value.
      get time stamp field return-changed_at.
      update zpdf_form_field from return.
    endif.

  endmethod.
ENDCLASS.
