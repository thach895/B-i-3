DELIMITER //
CREATE PROCEDURE CalculateHospitalFee(
    IN p_total_cost DECIMAL(18,2),
    IN p_patient_type VARCHAR(20),
    OUT p_final_amount DECIMAL(18,2),
    OUT p_message VARCHAR(100)
)
BEGIN
    IF p_total_cost < 0 THEN
        SET p_final_amount = 0;
        SET p_message = 'Lỗi: Chi phí không hợp lệ';
    ELSE
        CASE
            WHEN p_patient_type = 'BHYT' THEN
                SET p_final_amount = p_total_cost * 0.2;
            WHEN p_patient_type = 'VIP' THEN
                SET p_final_amount = p_total_cost * 0.9;
            WHEN p_patient_type = 'THUONG' THEN
                SET p_final_amount = p_total_cost;
            ELSE
                SET p_final_amount = p_total_cost;
        END CASE;
        SET p_message = 'Đã tính toán xong';
    END IF;
END //
DELIMITER ;