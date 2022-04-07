#!/bin/bash
# 检查叮咚买菜是否有可配送时段,有则通过Bark推送

# (*)请填充BarkId
barkId="1962259514"

while :; do

echo "正在检查是否有可用配送时段..."

# (*)请填充cURL命令,别忘记输出到tmp.json
curl 'https://maicai.api.ddxq.mobi/order/getMultiReserveTime'  -H 'Host: maicai.api.ddxq.mobi'  -H 'Connection: keep-alive'  -H 'Content-Length: 2160'  -H 'content-type: application/x-www-form-urlencoded'  -H 'ddmc-city-number: 0101'  -H 'ddmc-build-version: 2.82.0'  -H 'ddmc-device-id: osP8I0dsEAR5E1EBEZGrD9Rmx2Is'  -H 'ddmc-station-id: 611a57513ad68200016726ab'  -H 'ddmc-channel: applet'  -H 'ddmc-os-version: [object Undefined]'  -H 'ddmc-app-client-id: 4'  -H 'Cookie: DDXQSESSID=1488b10f763969b9a7828964e2a14e0e'  -H 'ddmc-ip: '  -H 'ddmc-longitude: 121.529976'  -H 'ddmc-latitude: 31.300178'  -H 'ddmc-api-version: 9.49.2'  -H 'ddmc-uid: 5c7e33c56079d10047984a87'  -H 'Accept-Encoding: gzip,compress,br,deflate'  -H 'User-Agent: Mozilla/5.0 (iPhone; CPU iPhone OS 15_3_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 MicroMessenger/8.0.18(0x1800123c) NetType/WIFI Language/zh_CN'  -H 'Referer: https://servicewechat.com/wx1e113254eda17715/422/page-frame.html'   --data 'uid=5c7e33c56079d10047984a87&longitude=121.529976&latitude=31.300178&station_id=611a57513ad68200016726ab&city_number=0101&api_version=9.49.2&app_version=2.82.0&applet_source=&channel=applet&app_client_id=4&sharer_uid=&s_id=1488b10f763969b9a7828964e2a14e0e&openid=osP8I0dsEAR5E1EBEZGrD9Rmx2Is&h5_source=&device_token=WHJMrwNw1k%2FF0qdLNvE01AcyXnixP7hmWqW8N%2FLpAmzTr7FY281Wnfq2Eiun8qFkcfU3SWicFp9HIHka%2Bz6GBM7Fhh2f5%2FqJKdCW1tldyDzmauSxIJm5Txg%3D%3D1487582755342&address_id=5c82375cb3e6fe3381868526&group_config_id=&products=%5B%5B%7B%22type%22%3A1%2C%22id%22%3A%2261dd57f3ca91e8c8ab3dee83%22%2C%22price%22%3A%2224.50%22%2C%22count%22%3A1%2C%22description%22%3A%22%22%2C%22sizes%22%3A%5B%5D%2C%22cart_id%22%3A%2261dd57f3ca91e8c8ab3dee83%22%2C%22parent_id%22%3A%22%22%2C%22parent_batch_type%22%3A-1%2C%22category_path%22%3A%22%22%2C%22manage_category_path%22%3A%2291%2C966%2C968%22%2C%22activity_id%22%3A%22%22%2C%22sku_activity_id%22%3A%22%22%2C%22conditions_num%22%3A%22%22%2C%22product_name%22%3A%22%E9%BB%91%E9%92%BB%E4%B8%96%E5%AE%B6%E9%BB%91%E7%8C%AA%E7%8C%AA%E6%B2%B9%20310g%22%2C%22product_type%22%3A0%2C%22small_image%22%3A%22https%3A%2F%2Fimgnew.ddimg.mobi%2Fproduct%2F1a4e667a205944a4b7bed593b72d5513.jpg%3Fwidth%3D800%26height%3D800%22%2C%22total_price%22%3A%2224.50%22%2C%22origin_price%22%3A%2224.50%22%2C%22total_origin_price%22%3A%2224.50%22%2C%22no_supplementary_price%22%3A%2224.50%22%2C%22no_supplementary_total_price%22%3A%2224.50%22%2C%22size_price%22%3A%220.00%22%2C%22buy_limit%22%3A0%2C%22price_type%22%3A0%2C%22promotion_num%22%3A0%2C%22instant_rebate_money%22%3A%220.00%22%2C%22is_invoice%22%3A1%2C%22sub_list%22%3A%5B%5D%2C%22is_booking%22%3A0%2C%22is_bulk%22%3A0%2C%22view_total_weight%22%3A%22%E4%BB%BD%22%2C%22net_weight%22%3A%22310%22%2C%22net_weight_unit%22%3A%22g%22%2C%22storage_value_id%22%3A0%2C%22temperature_layer%22%3A%22%22%2C%22sale_batches%22%3A%7B%22batch_type%22%3A-1%7D%2C%22is_shared_station_product%22%3A0%2C%22is_gift%22%3A0%2C%22supplementary_list%22%3A%5B%5D%2C%22order_sort%22%3A1%2C%22is_presale%22%3A0%7D%5D%5D&isBridge=false&nars=95bb3bbe5398911f38ef526e0c0d16df&sesi=ZuRXWc744290a0779298d149e745c83f280c6c0' --compressed  > tmp.json

responseCodeCheck=`cat tmp.json | jq -r '.code'`

if [[ $responseCodeCheck -ne 0 ]]; then
    cat tmp.json
    echo "😭 抱歉 请检查cURL命令是否能获取到正确的数据"
    exit 1
fi

availableCount=`cat tmp.json | jq -r '.data[0].time[0].times[].disableType' | grep -c 0`

if [[ $availableCount -gt 0 ]]; then
    echo "🎉 恭喜 发现可用的配送时段 请尽快下单!"
    curl "https://api.day.app/$barkId/叮咚买菜有可用配送时段请尽快下单/"
    exit 0
fi

echo "无可用配送时段 休眠15秒再试..."
sleep 15

done
