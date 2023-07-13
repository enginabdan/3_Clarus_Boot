import streamlit as st
import pandas as pd
import numpy as np
import datetime
from PIL import Image

st.title("Hello World!")
st.text("Bu bir text")
st.markdown("Bu bir markdown metnidir")
st.header("This is a header")
st.subheader("Subheader Aboooo")

st.success("Congrats!")
st.info("Warnings")
st.error("Gındıllandınız!")

st.help(str)
st.write("This is a text written with write func.")

img = Image.open("2.png")

st.image(img, caption="Skull") # use_column_width=True

st.video("https://www.youtube.com/watch?v=GH6MB7YH-Bg")

#Checkbox
if st.checkbox('Hide and Seek'):
	st.write('Seek')
    
status = st.radio("Who is your favourite instructor?", ("Edward","Orion","Johnson","Steve","Raife"))
st.write(f"Your favourite instructor is {status}")

if st.button("Tıkla ve Salih'in kim olduğunu öğren!"):
    st.success("Muhteşem, Fevkaladenin de Fevkinde Biri")
    
# SelectBox
selection = st.selectbox("Bir numara seç", [0,1,2,3,4,5,6,7,8,9])
if selection == 0:
    st.write("you chose number 0")
else:
    st.write("the number you chose is not 0")

multi_select = st.multiselect('Select multiple numbers', [0, 1, 2, 3, 4, 5])
if len(multi_select) > 0:
    st.write(f'you selected {multi_select}')
else:
    st.write('You didnt select anything')
    
slide = st.slider("Select a number", 0.0,5.0,3.0,0.1)

name = st.text_input("Write a name")
if st.button("Submit"):
    st.write(f"Hello, {name.title()}")

text_area = st.text_area("Enter a message", placeholder="Type your message to write here")

st.date_input("Date", datetime.datetime.now())  # Default date.
st.date_input("Date2", datetime.date(2021, 11, 20))  # By manually
st.time_input("Time", datetime.time(12,0))

birthday = st.date_input("When's your birthday", datetime.date(2019, 7, 6))
st.write('Your birthday is:', birthday)

with st.echo():
    import numpy as np
    import pandas as pd
    import matplotlib.pyplot as plt
    df = pd.DataFrame({"emir":[10,15,20], "han":[25,30,35]})
    df
 
st.sidebar.write("This will show on sidebar")
st.sidebar.title("This is the TITLE")
st.sidebar.slider("input", 0,5,1,1)
st.sidebar.markdown("## Markdown header")

df = pd.read_csv("Mall_Customers.csv")

st.table(df.head())  # only showing
st.write(df.head())  # dynamic "parse"
st.dataframe(df.head())  # dynamic and you can sort etc..

st.line_chart(df.Age)

x = st.slider("x")
srs = pd.Series(np.random.randn(x))

st.line_chart(srs.values)

st.line_chart(df.Age[:x])



















