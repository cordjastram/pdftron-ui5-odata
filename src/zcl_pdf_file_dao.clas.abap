class ZCL_PDF_FILE_DAO definition
  public
  final
  create protected .

public section.

  methods GET_ENTITY_SET
    importing
      !IV_WHERE_CLAUSE type STRING
    returning
      value(RETURN) type ZPDF_FILE_TT .
  class-methods GET_INSTANCE
    returning
      value(RETURN) type ref to ZCL_PDF_FILE_DAO .
  methods CREATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_FILE
    returning
      value(RETURN) type ZPDF_FILE .
  methods UPDATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_FILE
    returning
      value(RETURN) type ZPDF_FILE .
  methods GET_ENTITY
    importing
      !IV_ID type ZPDF_FILE-ID
    returning
      value(RETURN) type ZPDF_FILE .
  methods DELETE_ENTITY
    importing
      !IV_ID type ZPDF_FILE-ID
    returning
      value(RETURN) type ZPDF_FILE .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PDF_FILE_DAO IMPLEMENTATION.


  method create_entity.

    return           = is_entity.

    get time stamp field return-created_at.

    return-changed_at     = return-created_at.
    return-created_by     = sy-uname.
    return-changed_by     = sy-uname.
    return-file_size      = strlen( return-data ).

    check return-file_size > 0.

    call method cl_system_uuid=>if_system_uuid_static~create_uuid_c32
      receiving
        uuid = return-id.

    insert zpdf_file from return.

  endmethod.


  method delete_entity.

    delete from zpdf_file
        where id = iv_id.

    zcl_pdf_annotation_dao=>get_instance( )->delete_entities( iv_id ).
    zcl_pdf_form_field_dao=>get_instance( )->delete_entities( iv_id ).

  endmethod.


  method get_entity.

    select single * from zpdf_file into corresponding fields of return
        where id = iv_id.

    return-current_editor = sy-uname.

  endmethod.


  method GET_ENTITY_SET.

    select  id, created_by, form_imported, changed_by, created_at, changed_at, file_name, description, file_size, data, flattened
       from zpdf_file where (iv_where_clause) into corresponding fields of table @return.

    field-symbols  <return> like line of return.

     loop at return assigning <return>.
      <return>-current_editor = sy-uname.
    endloop.

  endmethod.


  method GET_INSTANCE.
    create object return.
  endmethod.


  method update_entity.

    check is_entity-id is not initial.

    return = is_entity.

    get time stamp field return-changed_at.
    return-changed_by = sy-uname.

    return-file_size   = strlen( return-data ).

    update zpdf_file
        set
              changed_by     = return-changed_by
              changed_at     = return-changed_at
              description    = return-description
              file_name      = return-file_name
              flattened      = return-flattened
              file_size      = return-file_size
              form_imported  = return-form_imported
              current_editor = space
              data           = return-data
        where
              id = is_entity-id.

  endmethod.
ENDCLASS.
