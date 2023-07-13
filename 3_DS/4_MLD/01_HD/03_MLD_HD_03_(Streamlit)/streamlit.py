# Bir .py dosyası açıyoruz
# İçini dolduruyoruz
# CMD veya Terminalde kod ile dosyayı açıyoruz
# streamlit run app.py
# ctrl + s
# WEB Browserda açılıyor
# .py dosyasına yazıp kaydet, sonucu webde çıkıyor
# WEB de ayarı her kaydette çalıştır olarak ayarla

import streamlit as st
import pandas as pd
import numpy as np
import datetime
from PIL import Image

st.write("https://docs.streamlit.io/")

st.title("Hello World")

st.text("Bu bir text")

st.markdown("# This is a markdown text")
st.markdown("## This is a markdown text")
st.markdown("### This is a markdown text")

st.header("This is a header")
st.subheader("Subheader hurra!")

st.success("Congrats!")
st.info("Warning!")
st.error("Dang!")

st.help(range) # Docstring kısmını getirir
st.help("engin")
st.help(12)

st.write("This is a text written with write function")

img = Image.open("cat.jfif")
st.image(img, caption="Cattie", use_column_width=True)

my_video = open("test.mp4", "rb")
st.video(my_video)
st.video("https://www.youtube.com/watch?v=lKq7UqplcL8")

if st.checkbox("Hide and Seek"):
    st.write("Seek")

status = st.radio("What is your favorouti color?", ("Red", "Green", "Blue"))
st.write(f"Your favourite colour is {status}")

if st.button("Unnecessarry button"):
    st.success("big brain move")

selected_number = st.selectbox("Select a number", [0,1,2,3,4,5])
if selected_number == 0:
    st.write("No cats for you -.-")
else:
    st.write(f"I am sending you {selected_number} cats")

multi_select = st.multiselect("Select multiple number", [0,1,2,3,4,5])
if len(multi_select)>0:
    st.write(f"you selected {multi_select}")
else:
    st.write("You didnt select anything")

st.slider("Select a number", 0,6,3,2)

st.slider("Select a number", 0.0, 5.0, 3.0, 0.1)

name = st.text_input("Enter your name")
if st.button("Submit"):
    st.write(f"Hello, {name.title()}")

st.text_area("Enter a message", "Type your message right here...", placeholder=None)
# Buraya girilen metni bir değere atayıp bunu alıp işleyebiliriz.

st.date_input("Date", datetime.datetime.now())

st.time_input("Time", datetime.time(12,0,10))

st.code("import pandas as pd \nimport numpy as np")

with st.echo():
    import streamlit as st
    import pandas as pd
    import numpy as np
    df = pd.DataFrame({"a":[1,2,3], "b":[4,5,6]})
    df

st.sidebar.write("This will show on sidebar")
st.sidebar.title("Sidebar Title")
st.sidebar.slider("input", 0, 5, 1, 1)
st.sidebar.markdown("## Markdown header")

df = pd.read_csv("Mall_Customers.csv")
st.table(df.head())
st.write(df.head()) #interactive, çok kullanışlı 
st.dataframe(df.head())

st.line_chart(df["Age"])

x = st.slider("x")
srs = pd.Series(np.random.randn(x))
st.line_chart(srs.values)

y = st.slider("y")
st.line_chart(df["Age"][:y])