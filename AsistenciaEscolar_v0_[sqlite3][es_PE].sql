/*
@description Registro de la Asistencia Escolar individual (x Alumno)
@author Luis Carrillo Gutiérrez
@date Abril, 2018
@version 0.0.0.1
*/

DROP TABLE IF EXISTS [Alumno];
CREATE TABLE IF NOT EXISTS [Alumno]
(
	[id] INTEGER NOT NULL PRIMARY KEY,
	[número del documento de identidad] CHAR(14) NOT NULL,
	[nombres] VARCHAR(64) NOT NULL,
	[primer apellido] VARCHAR(64) NOT NULL,
	[segundo apellido] VARCHAR(64) NOT NULL,
	[estado] BOOLEAN NOT NULL -- CHAR(1)
) WITHOUT RowId;

DROP TABLE IF EXISTS [Grupo Académico];
CREATE TABLE IF NOT EXISTS [Grupo Académico]
(
	[id] INTEGER NOT NULL PRIMARY KEY,
	[grado académico] INTEGER NOT NULL, -- UNSIGNED or CHECK?
	[sección] CHAR(1) NOT NULL DEFAULT 'a', 
	[denominación] VARCHAR(64) NOT NULL,
	[estado] BOOLEAN NOT NULL
) WITHOUT RowId;

DROP TABLE IF EXISTS [Matrícula];
CREATE TABLE IF NOT EXISTS [Matrícula]
(
	[id] INTEGER NOT NULL PRIMARY KEY,
	[año lectivo] INTEGER NOT NULL, -- CHAR(4) 
	[id alumno] INTEGER NOT NULL REFERENCES [Alumno](id),
	[id grupo académico] INTEGER NOT NULL REFERENCES [Grupo Académico](id),
	[estado] BOOLEAN NOT NULL
) WITHOUT RowId;

-- Asignatura / Curso
DROP TABLE IF EXISTS [Área Curricular];
CREATE TABLE IF NOT EXISTS [Área Curricular]
(
	[id] INTEGER NOT NULL PRIMARY KEY,
	[denominación] VARCHAR(64) NOT NULL,
	[estado] BOOLEAN NOT NULL
) WITHOUT RowId;

-- Curso x Dia y Hora en la semana
DROP TABLE IF EXISTS [Programación Escolar];
CREATE TABLE IF NOT EXISTS [Programación Escolar]
(
	[id] INTEGER NOT NULL PRIMARY KEY,
	[id asignatura] INTEGER NOT NULL REFERENCES [Área Curricular](id),
	[día de la semana] INTEGER UNSIGNED NOT NULL, -- Lunes(1) .. Domingo(7)
	[hora de inicio de sesión] INTEGER NOT NULL, -- (hora * 60 + min) 11 * 60 + 59
	[hora de cierre de sesión] INTEGER NOT NULL,
	[estado] BOOLEAN NOT NULL
) WITHOUT RowId;

-- Registro de la asistencia escolar individual (x alumno)
DROP TABLE IF EXISTS [Asistencia Escolar];
CREATE TABLE IF NOT EXISTS [Asistencia Escolar]
(
	[id matrícula] INTEGER NOT NULL REFERENCES [Matrícula](id),
	[id programación escolar] INTEGER NOT NULL REFERENCES [Programación Escolar](id),
	[fecha registrada] CHAR(6) NOT NULL, -- 02-MAR
	[asistencia registrada] BOOLEAN NOT NULL, -- BIT 
	[puntualidad] BOOLEAN NOT NULL,
	PRIMARY KEY('id matrícula', 'id programación escolar', 'fecha registrada')
) WITHOUT RowId;
