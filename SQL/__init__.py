import os

from sqlalchemy import create_engine
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session

engine = create_engine(
    f"postgresql://{os.getenv('DB_USERNAME')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}/{os.getenv('DB_NAME')}")
Base = automap_base()
Base.prepare(engine, reflect=True)

# Creating Python objects
UserDimension = Base.classes.user_dimension
DiagnosticDimension = Base.classes.diagnostic_dimension
DiseaseDimension = Base.classes.disease_dimension
DiseaseStageDimension = Base.classes.disease_stage_dimension
ImagesDimension = Base.classes.images_dimension
MedicalFact = Base.classes.medical_fact
PatientAttachmentsDimension = Base.classes.patient_attachments_dimension
PatientDimension = Base.classes.patient_dimension
SymptomDimension = Base.classes.symptom_dimension
TreatmentDimension = Base.classes.user_dimension

session = Session(engine)
