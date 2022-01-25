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

/*--------------PRUEBA---------------*/
call transaccion_uno('SDF57',11536,'Tiene un error debido a una cirugía mal hecha en el pie y en la mano','El niño puede caminar','El niño no puede caminar',1)

select * from doctor_asignacion