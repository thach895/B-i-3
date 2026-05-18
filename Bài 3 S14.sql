DELIMITER //

CREATE PROCEDURE IssueMedicine(
    IN p_patient_id INT,
    IN p_medicine_id INT,
    IN p_quantity INT,
    OUT p_message VARCHAR(255)
)
BEGIN

    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);

    START TRANSACTION;

    -- Lấy tồn kho và đơn giá
    SELECT stock, price
    INTO v_stock, v_price
    FROM Medicines
    WHERE medicine_id = p_medicine_id;

    -- Kiểm tra tồn kho
    IF v_stock >= p_quantity THEN

        -- Trừ kho
        UPDATE Medicines
        SET stock = stock - p_quantity
        WHERE medicine_id = p_medicine_id;

        -- Cộng công nợ
        UPDATE Patient_Invoices
        SET total_due = total_due + (p_quantity * v_price)
        WHERE patient_id = p_patient_id;

        COMMIT;

        SET p_message = 'Đã cấp phát thành công';

    ELSE

        ROLLBACK;

        SET p_message = 'Lỗi: Số lượng tồn kho không đủ';

    END IF;

END //

DELIMITER ;