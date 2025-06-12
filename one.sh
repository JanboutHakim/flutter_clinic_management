#!/bin/bash

# Create core directories
mkdir -p lib/core/{constants,errors,network,usecases,utils,widgets}

# Create features structure
create_feature() {
  feature_name=$1
  mkdir -p lib/features/$feature_name/{data,domain,presentation}
  mkdir -p lib/features/$feature_name/data/{datasources,models,repositories}
  mkdir -p lib/features/$feature_name/domain/{entities,repositories,usecases}
  mkdir -p lib/features/$feature_name/presentation/{bloc,pages,widgets}
  
  # Create basic files
  touch lib/features/$feature_name/data/repositories/${feature_name}_repository_impl.dart
  touch lib/features/$feature_name/domain/repositories/${feature_name}_repository.dart
}

# Create auth feature
create_feature "auth"
# Create basic auth usecases
touch lib/features/auth/domain/usecases/{login_usecase,signup_usecase,user_type_check_usecase}.dart
# Create auth presentation pages
touch lib/features/auth/presentation/pages/{login_page,signup_page,user_type_selection}.dart

# Create admin feature
create_feature "admin"
touch lib/features/admin/presentation/pages/{admin_dashboard,user_management,system_settings}.dart

# Create doctor feature
create_feature "doctor"
# Create doctor usecases
touch lib/features/doctor/domain/usecases/{get_appointments_usecase,update_profile_usecase,add_holiday_usecase,manage_appointment_usecase}.dart
# Create doctor presentation
touch lib/features/doctor/presentation/bloc/{doctor_appointments_bloc,doctor_profile_bloc}.dart
touch lib/features/doctor/presentation/pages/{doctor_dashboard,doctor_profile,appointments_list,appointment_detail,holiday_management}.dart

# Create patient features
create_feature "patient"
# Create patient sub-features
create_patient_subfeature() {
  subfeature=$1
  mkdir -p lib/features/patient/$subfeature/{data,domain,presentation}
  mkdir -p lib/features/patient/$subfeature/presentation/{bloc,pages}
}

create_patient_subfeature "appointments"
touch lib/features/patient/appointments/presentation/pages/{book_appointment,doctor_search,appointment_history}.dart

create_patient_subfeature "medication"
touch lib/features/patient/medication/presentation/pages/{medication_list,add_medication,medication_reminder}.dart

create_patient_subfeature "health_records"
touch lib/features/patient/health_records/presentation/pages/{health_documents,upload_document,document_viewer}.dart

create_patient_subfeature "profile"
touch lib/features/patient/profile/presentation/pages/{patient_profile,edit_profile}.dart

# Create notifications feature
create_feature "notifications"
touch lib/features/notifications/presentation/pages/notification_center.dart

# Create main files
touch lib/injection_container.dart
touch lib/main.dart

echo "Flutter project structure created successfully!"
