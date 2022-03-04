USE controlescolar_bd
go
 

ALTER TRIGGER [dbo].[tu_banderas] on [dbo].[banderas] for update as
begin
if @@rowcount = 1
begin
if update(insc_sem_ant) 
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.insc_sem_ant = d.insc_sem_ant) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                         SELECT d.cuenta, 2, d.insc_sem_ant, i.insc_sem_ant FROM deleted d,inserted i
if update(cve_flag_promedio)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_flag_promedio = d.cve_flag_promedio) = 0
     INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 3, d.cve_flag_promedio, i.cve_flag_promedio FROM deleted d,inserted i
if update(baja_3_reprob)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.baja_3_reprob = d.baja_3_reprob) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 4, d.baja_3_reprob, i.baja_3_reprob FROM deleted d,inserted i
if update(baja_4_insc)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.baja_4_insc = d.baja_4_insc) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 5, d.baja_4_insc, i.baja_4_insc FROM deleted d,inserted i
if update(baja_disciplina)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.baja_disciplina = d.baja_disciplina) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 6, d.baja_disciplina, i.baja_disciplina FROM deleted d,inserted i
if update(baja_documentos)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.baja_documentos = d.baja_documentos) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
SELECT d.cuenta, 7, d.baja_documentos, i.baja_documentos FROM deleted d,inserted i
if update(invasor_hora)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.invasor_hora = d.invasor_hora) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 8, d.invasor_hora, i.invasor_hora FROM deleted d,inserted i
if update(exten_cred)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.exten_cred = d.exten_cred) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 9, d.exten_cred, i.exten_cred FROM deleted d,inserted i
if update(cve_flag_prerreq_ingles)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_flag_prerreq_ingles = d.cve_flag_prerreq_ingles) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 10, d.cve_flag_prerreq_ingles, i.cve_flag_prerreq_ingles FROM deleted d,inserted i
if update(cve_flag_serv_social)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_flag_serv_social = d.cve_flag_serv_social) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 11, d.cve_flag_serv_social, i.cve_flag_serv_social FROM deleted d,inserted i
if update(puede_integracion)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.puede_integracion = d.puede_integracion) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                  SELECT d.cuenta, 12, d.puede_integracion, i.puede_integracion FROM deleted d,inserted i
if update(tema_fundamental_1)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_fundamental_1 = d.tema_fundamental_1) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 13, d.tema_fundamental_1, i.tema_fundamental_1 FROM deleted d,inserted i
if update(tema_fundamental_2)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_fundamental_2 = d.tema_fundamental_2) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
     SELECT d.cuenta, 14, d.tema_fundamental_2, i.tema_fundamental_2 FROM deleted d,inserted i
if update(tema_1)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_1 = d.tema_1) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 15, d.tema_1, i.tema_1 FROM deleted d,inserted i
if update(tema_2)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_2 = d.tema_2) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 16, d.tema_2, i.tema_2 FROM deleted d,inserted i
if update(tema_3)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_3 = d.tema_3) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 17, d.tema_3, i.tema_3 FROM deleted d,inserted i
if update(tema_4)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.tema_4 = d.tema_4) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 18, d.tema_4, i.tema_4 FROM deleted d,inserted i
if update(creditos_integ)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.creditos_integ = d.creditos_integ) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 19, d.creditos_integ, i.creditos_integ FROM deleted d,inserted i
if update(cve_flag_biblioteca)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_flag_biblioteca = d.cve_flag_biblioteca) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                SELECT d.cuenta, 20, d.cve_flag_biblioteca, i.cve_flag_biblioteca FROM deleted d,inserted i
if update(cve_flag_diapositeca)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.cve_flag_diapositeca = d.cve_flag_diapositeca) = 0
    INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 21, d.cve_flag_diapositeca, i.cve_flag_diapositeca FROM deleted d,inserted i
if update(adeuda_finanzas)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.adeuda_finanzas = d.adeuda_finanzas) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 22, d.adeuda_finanzas, i.adeuda_finanzas FROM deleted d,inserted i
if update(baja_laboratorio)
 if (SELECT COUNT(*) FROM inserted i, deleted d WHERE i.baja_laboratorio = d.baja_laboratorio) = 0
            INSERT INTO ui_bibanderas(cuenta,bandera, anterior, actual)
                        SELECT d.cuenta, 23, isnull(d.baja_laboratorio,0), i.baja_laboratorio FROM deleted d,inserted i
end
end

GO

