# ------------------------------------------------------------
# Puppies sample — hardcoded local MySQL connection
# NOTE: best practice is putting passwords in .streamlit/secrets.toml,
# but we're hardcoding here to keep things as simple as possible.
# ------------------------------------------------------------
import streamlit as st
import mysql.connector

st.set_page_config(page_title="Pizza Toppingsc", layout="centered")
st.title("Pizzasssss 🍕")

# ------ SAME CONNECTION INFO YOU'LL USE IN BOTH FILES ------
HOST = "127.0.0.1"   # local MySQL, you could also type “localhost”
PORT = 3306          # use 3307 if you installed a second instance
DB   = "Pizzas"     # <- puppy sample database
USER = "root"        # or 'class_admin'
PWD  = "mezqan-Panpoz-7womju"  # or change to your local password

def run_query(sql, params=()):
    conn = mysql.connector.connect(host=HOST, port=PORT, user=USER, password=PWD, database=DB)
    cur = conn.cursor(dictionary=True)
    cur.execute(sql, params)
    rows = cur.fetchall()
    cur.close(); conn.close()
    return rows

def get_conn():
    return mysql.connector.connect(
        host=HOST, port=PORT, user=USER, password=PWD, database=DB
    ) 

def query_rows(sql, params=()):
    conn = get_conn()
    cur = conn.cursor(dictionary=True)
    cur.execute(sql, params)
    rows = cur.fetchall()
    cur.close(); conn.close()
    return rows

def execute_sql(sql, params=()):
    conn = get_conn()
    cur = conn.cursor()
    cur.execute(sql, params)
    conn.commit()
    cur.close(); conn.close()

#------------------------------------------------------------

#insert a new pizza, then list all pizzas

st.subheader("Add a new Base Pizza 🥹")

new_pizza_name = st.text_input("New Pizza (name)", value="")

#puts 2 boottons side by side
col1, col2 = st.columns([1,1])

with col1: #first button
    if st.button("Insert Pizza"):
        p = new_pizza_name.strip()
        if not p:
            st.warning("Please type a pizza name.")
        else:
            try:
                EXISTS_SQL = "SELECT 1 FROM Base_Pizzas WHERE LOWER(Pizza_name) = LOWER(%s) LIMIT 1"
                exists = query_rows(EXISTS_SQL, (p,)) 
            
                if exists:
                    st.info("That pizza already exists.")
                else:
                    INSERT_SQL = "INSERT INTO Base_Pizzas (Pizza_name) VALUES (%s)" #insert new pizza
                    
                    #insert the new pizza
                    execute_sql(INSERT_SQL, (p,)) 
                    
                    #message to user
                    st.success(f"Inserted pizza: {p}")
            except Exception as e:
                st.error(f"Insert failed: {e}")

# for listing the pizzas
with col2: #second button
    if st.button("Refresh list"):
        pass  
try:
    #List all Base Pizzas
    LIST_SQL = "SELECT Pizza_id, Pizza_name FROM Base_Pizzas ORDER BY Pizza_name;"
    pizzas = run_query(LIST_SQL)
    st.caption("All Base Pizzas:")
    st.table(pizzas if pizzas else [{"info": "No pizzas yet."}])
except Exception as e:
    st.error(f"Failed to load pizzas: {e}")

#------------------------------------------------------------

# given a pizza name, list its toppings 

#query to find all toppings for a given pizza name
SQL = """
SELECT
    i.Ingredient_name AS Topping_or_Ingredient
FROM
    Base_Pizzas bp
JOIN
    Recipes r ON r.Pizza_id = bp.Pizza_id
JOIN
    Ingredients i ON i.Ingredient_id = r.Ingredient_id
WHERE
    bp.Pizza_name LIKE %s
ORDER BY
    i.Ingredient_name;
"""

# find toppings for a given pizza name

st.subheader("Find Toppings for a Pizza 🍄‍🟫🍅🧅🧄🫓")
name = st.text_input("Pizza name contains", value="")
if st.button("Show toppings"):
    try:
        rows = run_query(SQL, (f"%{name.strip()}%",))
        st.table(rows if rows else [{"info": "No toppings found"}])
    except Exception as e:
        st.error(str(e))







