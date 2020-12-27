class ZCL_PDF_ANNOTATION_DAO definition
  public
  final
  create public .

public section.

  methods GET_ENTITY_SET
    importing
      !IV_ID type Z_FILE_ID
      !IV_WHERE_CLAUSE type STRING
    returning
      value(RETURN) type ZPDF_ANNOTATION_TT .
  methods DELETE_ENTITIES
    importing
      !IV_ID type Z_FILE_ID .
  methods DELETE_ENTITY
    importing
      !IV_ID type Z_FILE_ID
      !IV_ANNOTATION_ID type Z_ANNOTATION_ID .
  methods UPDATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_ANNOTATION
    returning
      value(RETURN) type ZPDF_ANNOTATION .
  class-methods GET_INSTANCE
    returning
      value(RETURN) type ref to ZCL_PDF_ANNOTATION_DAO .
  methods CREATE_ENTITY
    importing
      !IS_ENTITY type ZPDF_ANNOTATION
    returning
      value(RETURN) type ZPDF_ANNOTATION .
  methods GET_ENTITY
    importing
      !IV_ID type Z_FILE_ID
      !IV_ANNOTATION_ID type Z_ANNOTATION_ID
    returning
      value(RETURN) type ZPDF_ANNOTATION .
protected section.
private section.
ENDCLASS.



CLASS ZCL_PDF_ANNOTATION_DAO IMPLEMENTATION.


  method create_entity.

    data ls_entity type zpdf_annotation.

    check is_entity-id is not initial.

    ls_entity = is_entity.

*-- check level for tree table
    if ls_entity-in_reply_to is not initial.
      ls_entity-hierarchy_level = 1.
    else.
      ls_entity-hierarchy_level = 0.
    endif.

*-- timestamps
    get time stamp field ls_entity-created_at.
    ls_entity-changed_at = ls_entity-created_at.

    insert zpdf_annotation from ls_entity.

    return = ls_entity.

  endmethod.


  method DELETE_ENTITIES.

    delete from  zpdf_annotation
      where
        id = iv_id.

  endmethod.


  method DELETE_ENTITY.

    delete from  zpdf_annotation
      where
        id = iv_id AND
        annotation_id = iv_annotation_id.

  endmethod.


  method get_entity.

    select single * from zpdf_annotation into return
        where
          id = iv_id and
          annotation_id = iv_annotation_id.


  endmethod.


  method GET_ENTITY_SET.

    field-symbols <return> like line of return.

    select * from zpdf_annotation  into corresponding fields of table return
       where id = iv_id and (iv_where_clause) order by page_nr ypos created_at .

    loop at return assigning <return>.

      <return>-drill_state = 'leaf'.

      if <return>-in_reply_to is initial.
        select count(*) from zpdf_annotation
          where
            id = <return>-id and
            in_reply_to = <return>-annotation_id.

          if sy-subrc = 0.
            <return>-drill_state = 'expanded'.
          endif.
      else.

      endif.
    endloop.

  endmethod.


  method GET_INSTANCE.

    create object return.

  endmethod.


  method update_entity.

    data ls_entity type zpdf_annotation.

    select single * from zpdf_annotation
        into ls_entity where id = is_entity-id and
                             annotation_id = is_entity-annotation_id.

    check sy-subrc = 0.

    if ls_entity-content ne is_entity-content or
       ls_entity-state   ne is_entity-state   or
       ls_entity-ypos    ne is_entity-ypos.

      ls_entity-content   = is_entity-content.
      ls_entity-state     = is_entity-state.
      ls_entity-ypos      = is_entity-ypos.
      get time stamp field ls_entity-changed_at.

      update zpdf_annotation from ls_entity.
    endif.

  endmethod.
ENDCLASS.
