/* TRANSACTION UNO --MALO-- */
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
