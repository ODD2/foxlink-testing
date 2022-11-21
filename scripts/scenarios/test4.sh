# Step1
# Clean the database and wait til backend's restart process done
bash clean.sh
sleep 5

# Step2 
# Run the script to test Login Logout
python app/utils/create_time.py -f test4  # 重新設定測項 Json 檔內容
cp app/env_template.py app/env.py
sed -i 's/test.json/test4.json/' app/env.py # 設定要執行的 Json 檔名
docker-compose up -d --build foxlinkevent # 執行輸入 foxlinkevent 的 container
docker-compose kill worker && docker-compose up --build worker # 執行模擬員工的 container