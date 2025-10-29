"""
Pipeline de data science.
"""

from kedro.pipeline import Pipeline, node, pipeline
from .nodes import (
    train_regression_models,
    train_classification_models,
    make_regression_predictions,
    make_classification_predictions,
)


def create_pipeline(**kwargs) -> Pipeline:
    """
    Crea el pipeline de data science.
    
    Returns:
        Pipeline de Kedro con entrenamiento de modelos
    """
    return pipeline(
        [
            # Regresión
            node(
                func=train_regression_models,
                inputs=["X_train_scaled", "y_reg_train", "params:model_options"],
                outputs="regression_models",
                name="train_regression_models_node",
            ),
            node(
                func=make_regression_predictions,
                inputs=["regression_models", "X_train_scaled", "X_test_scaled"],
                outputs="regression_predictions",
                name="make_regression_predictions_node",
            ),
            # Clasificación
            node(
                func=train_classification_models,
                inputs=["X_train_scaled", "y_cls_train", "params:model_options"],
                outputs="classification_models",
                name="train_classification_models_node",
            ),
            node(
                func=make_classification_predictions,
                inputs=["classification_models", "X_train_scaled", "X_test_scaled"],
                outputs="classification_predictions",
                name="make_classification_predictions_node",
            ),
        ]
    )




