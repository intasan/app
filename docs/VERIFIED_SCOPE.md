# ขอบเขตที่ตรวจสอบจากระบบจริง

Repository: `intasan/app`
ฐาน source ที่ตรวจ: `7f1452d53f2d3fc98dc88203f92ff3b41072f516`

**สถานะ: ยังรันไม่ได้**

ไม่มี Flutter SDK ในสภาพแวดล้อมนี้; การพิสูจน์ MQTT และ LED ต้องมีอุปกรณ์และ broker จริง

## แหล่งหลักฐาน

- [evidence/source-audit.json](../evidence/source-audit.json)
- [evidence/attempt-test.txt](../evidence/attempt-test.txt)

## Traceability จาก source

| ไฟล์ที่ตรวจ | ขอบเขตที่ยืนยันได้ |
|---|---|
| [app/lib/home_page.dart](../app/lib/home_page.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |
| [app/lib/home_page_mqtt.dart](../app/lib/home_page_mqtt.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |
| [app/lib/home_service.dart](../app/lib/home_service.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |
| [app/lib/main.dart](../app/lib/main.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |
| [app/lib/mqtt_service.dart](../app/lib/mqtt_service.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |
| [app/test/widget_test.dart](../app/test/widget_test.dart) | พบ source ใน commit ข้างต้น; การมีไฟล์ไม่ใช่การทดสอบผ่าน |

## เกณฑ์ตรวจรับ BA / SA

| เกณฑ์ | หลักฐาน / สถานะ |
|---|---|
| ขอบเขตปัจจุบันตรงกับ source | ยังรันไม่ได้ |
| End-to-end ด้วยข้อมูลจริง | ไม่มี Flutter SDK ในสภาพแวดล้อมนี้; การพิสูจน์ MQTT และ LED ต้องมีอุปกรณ์และ broker จริง |
| ผลการทดสอบที่ทำซ้ำได้ | อ่าน command, stdout, exit code ใน evidence; syntax check ไม่ใช่ runtime test |
| ข้อมูลจริงและ provenance | เฉพาะราคาทองใน live-verification.txt ที่มี URL/เวลา publication; ไม่ใช้ fixture เป็นข้อมูลจริง |
| UAT โดยเจ้าของงานหรือผู้ใช้งาน | ยังไม่ได้ดำเนินการในรอบนี้ |

## ข้อจำกัดการแสดงผลงาน

ผล unit tests เป็นการตรวจ logic โดยมี fixture ตาม suite เดิม ไม่ใช่หลักฐานธุรกรรมจริง การฝึกโมเดลจริง การทำงานของอุปกรณ์จริง หรือการรับรองจากผู้ใช้ ไม่สร้างข้อมูลธุรกิจทดแทนข้อมูลที่ขาด และไม่อนุมานว่าไม่มีข้อมูลเท่ากับปลอดภัย
