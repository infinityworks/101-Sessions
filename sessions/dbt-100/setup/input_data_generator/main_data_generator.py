import os
import numpy as np

from datetime import datetime
from dateutil.relativedelta import relativedelta

from data_generator import (
    generate_customers,
    generate_products,
    generate_transactions,
)

if __name__ == "__main__":
    np.random.seed(seed=42)

    products_data = {
        "AUDI": ["A1", "Q5", "A4 ALLROAD", "RS5", "S5", "TTS"],
        "BMW": [
            "I8",
            "1 SERIES",
            "X3",
            "Z4",
            "5 ",
            "6 SERIES",
            "X5",
            "8 SERIES",
        ],
        "CITROEN": [
            "C4 PICASSO",
            "C3",
            "C5",
            "GRAND C4 PICASSO",
            "BERLINGO MULTISPACE",
            "DS3",
            "C4 CACTUS",
            "C3 AIRCROSS",
            "C1",
        ],
        "DACIA": ["SANDERO", "DUSTER", "LOGAN", "SANDERO STEPWAY"],
        "FIAT": ["500", "DOBLO", "TIPO", "500X", "PANDA", "500L"],
        "FORD": [
            "MONDEO VIGNALE",
            "PUMA",
            "FIESTA VIGNALE",
            "C-MAX",
            "KUGA VIGNALE",
            "GRAND C-MAX",
            "S-MAX VIGNALE",
            "KA",
            "KA+",
            "FOCUS",
            "FIESTA",
            "MONDEO",
            "S-MAX",
            "B-MAX",
            "TOURNEO CONNECT",
            "ECOSPORT",
            "FOCUS VIGNALE",
            "MUSTANG",
            "KUGA",
            "GRAND TOURNEO CONNECT",
        ],
    }
    products_cats_frequency = (
        ["AUDI"] * 15
        + ["BMW"] * 15
        + ["CITROEN"] * 25
        + ["DACIA"] * 20
        + ["FIAT"] * 25
        + ["FORD"] * 25
    )

    gen_id = "starter"
    output_location = f"./input_data/{gen_id}"
    os.makedirs(output_location, exist_ok=True)

    gen_customers = generate_customers(output_location, 137)
    product_id_lookup = generate_products(output_location, products_data)

    end_date = datetime.today()
    delta = relativedelta(months=3)
    start_date = end_date - delta

    generate_transactions(
        output_location,
        gen_customers,
        products_data,
        product_id_lookup,
        products_cats_frequency,
        start_date,
        end_date,
    )
