
/* TRANSACTION DOS --MALA-- */
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