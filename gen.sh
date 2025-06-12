#!/bin/bash

# Feature name from user input
FEATURE_NAME=$1

if [ -z "$FEATURE_NAME" ]; then
  echo "Usage: ./create_feature.sh feature_name"
  exit 1
fi

# Lowercase + snake_case
FEATURE_NAME_SNAKE=$(echo "$FEATURE_NAME" | sed 's/\([A-Z]\)/_\L\1/g' | sed 's/^_//')
FEATURE_DIR="lib/features/${FEATURE_NAME_SNAKE}"

# Create folder structure
mkdir -p $FEATURE_DIR/data/datasources
mkdir -p $FEATURE_DIR/data/models
mkdir -p $FEATURE_DIR/data/repositories

mkdir -p $FEATURE_DIR/domain/entities
mkdir -p $FEATURE_DIR/domain/repositories
mkdir -p $FEATURE_DIR/domain/usecases

mkdir -p $FEATURE_DIR/presentation/bloc
mkdir -p $FEATURE_DIR/presentation/pages
mkdir -p $FEATURE_DIR/presentation/widgets

# Bloc file names
BLOC_DIR="$FEATURE_DIR/presentation/bloc"
BLOC_FILE="${FEATURE_NAME_SNAKE}_bloc.dart"
EVENT_FILE="${FEATURE_NAME_SNAKE}_event.dart"
STATE_FILE="${FEATURE_NAME_SNAKE}_state.dart"

# Create empty bloc class files with boilerplate
cat <<EOL > $BLOC_DIR/$EVENT_FILE
part of '${FEATURE_NAME_SNAKE}_bloc.dart';

abstract class ${FEATURE_NAME^}Event {}

class Load${FEATURE_NAME^}Event extends ${FEATURE_NAME^}Event {}
EOL

cat <<EOL > $BLOC_DIR/$STATE_FILE
part of '${FEATURE_NAME_SNAKE}_bloc.dart';

abstract class ${FEATURE_NAME^}State {}

class ${FEATURE_NAME^}Initial extends ${FEATURE_NAME^}State {}
EOL

cat <<EOL > $BLOC_DIR/$BLOC_FILE
import 'package:flutter_bloc/flutter_bloc.dart';
part '${FEATURE_NAME_SNAKE}_event.dart';
part '${FEATURE_NAME_SNAKE}_state.dart';

class ${FEATURE_NAME^}Bloc extends Bloc<${FEATURE_NAME^}Event, ${FEATURE_NAME^}State> {
  ${FEATURE_NAME^}Bloc() : super(${FEATURE_NAME^}Initial()) {
    on<Load${FEATURE_NAME^}Event>((event, emit) {
      // TODO: implement logic
    });
  }
}
EOL

echo "✅ Feature '$FEATURE_NAME' created successfully at $FEATURE_DIR"

