import streamlit as st
st.title("Kıtaya dönüştürücü.")
path = None
path = st.file_uploader("Upload yuor txt file :", type = ["txt"])
if path :
    with open(path, "r", encoding="utf-8") as engin :
        lines = engin.readlines()
    a = 0
    with open(path, "w", encoding="utf-8") as engin :
        for i in lines :
            a += 1
            if a %4 == 0 :
                engin.write(i + "\n")
            else :
                engin.write(i)
