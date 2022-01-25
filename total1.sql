/*TRANSACTION UNO --BUENA-- */
create or replace procedure transaccion_uno(tratamientoid char(10),docAsigId int,tratamientoDescripcion char(100),tratamientoRazon char(100), DocSintomas char(100), DocNivelGravedad int)
as
$$
declare
    x int;
    begin
            insert into tratamiento(tratamiento_id,doc_asig_id,tratamiento_descripcion,tratamiento_razon) values(tratamientoid,docAsigId, tratamientoDescripcion, tratamientoRazon);
            update doctor_asignacion set doc_sintomas = DocSintomas, doc_nivel_gravedad = DocNivelGravedad where doc_asig_id = docAsigId;
            select doc_nivel_gravedad into x from doctor_asignacion where doc_asig_id = docAsigId;
            if (x=1) then
                    update doctor_asignacion set doc_estado ='Estable' where doc_asig_id = docAsigId;
            else
                if(x=2) then
                    update doctor_asignacion set doc_estado = 'Inestable' where doc_estado = docAsigId;
                else
                    if(x=3) then
                        update doctor_asignacion set doc_estado = 'Desconocido' where doc_estado = docAsigId;
                    else
                        raise exception 'No se encuentra el nivel';
                        rollback;
                    end if;
                end if;
            end if;
    exception
            when sqlstate '23514' then
            raise exception 'No se realizo la transaccion.';
    commit;
end;
$$
language plpgsql;

-- CAMBIAR TRTAMIENTO ID Y NIVEL DE GRAVEDAD 1= ESTABLE, 2 INESTABLE, 3 DESCONOCIDO






/* TRANSACTION ONE FAIL */
create or replace procedure transaccion_unomalo(tratamientoid char(10),docAsigId int,tratamientoDescripcion char(100),tratamientoRazon char(100), DocSintomas char(100), DocNivelGravedad int)
as
$$
declare
    x int;
    begin
        insert into tratamiento(tratamiento_id,doc_asig_id,tratamiento_descripcion,tratamiento_razon) values(tratamientoid, docAsigId, tratamientoDescripcion, tratamientoRazon);
        update doctor_asignacion set doc_sintomas = DocSintomas, doc_nivel_gravedad = DocNivelGravedad where doc_asig_id = docAsigId;
        select doc_nivel_gravedad into x from doctor_asignacion where doc_asig_id = docAsigId;
        update doctor_asignacion set doc_estado ='Estable' where doc_asig_id = docAsigId;
    end;
$$
language plpgsql;

-- CAMBIAR TRTAMIENTO ID Y NIVEL DE  3 DESCONOCIDO PERO SALDRA ESTABLE







/* TRANSACTION TWO GOOD */

create or replace procedure transaccion_dos(estipendioId char(10), huerfanoId char(10), estipendioMesada int, estipendioDescripcion char(40), huerfanoDetalleComportamiento char(30))
as
$$
declare
    x int;
    begin
        insert into estip_mensual(estipendio_id, huerfano_id, estipendio_mesada, estipendio_descripcion)values(estipendioId, huerfanoId, estipendioMesada, estipendioDescripcion);
        update huerfano set huerfano_detalle_comportamiento = huerfanoDetalleComportamiento where huerfano_id = huerfanoId;
    exception
            when sqlstate '23514' then
            raise exception 'No se realizo la transaccion.';
        rollback;
        commit;
    end;
$$
language plpgsql;

-- CAMBIAR LA ID DE TRATAMIENTO Y EL NIVEL DE GRAVEDAD








/* TRANSACTION TWO FAIL */

create or replace procedure transaccion_dosmalo(estipendioId char(10), huerfanoId char(10), estipendioMesada int, estipendioDescripcion char(40), huerfanoDetalleComportamiento char(30))
as
$$
declare
    x int;
    begin
        insert into estip_mensual(estipendio_id, huerfano_id, estipendio_mesada, estipendio_descripcion)values(estipendioId, huerfanoId, estipendioMesada, estipendioDescripcion);
        update huerfano set huerfano_detalle_comportamiento = huerfanoDetalleComportamiento where huerfano_id = huerfanoId;
    end;
$$
language plpgsql;

-- CAMBIAR LA ID DE ESTIPENDIO Y EL COMPORTAMIENTO