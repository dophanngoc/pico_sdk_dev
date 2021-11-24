//****************************************//
/*
* Author: Do Pan
* Email: do******@gmail.com
*
*/
//****************************************//
#include <stdio.h>
#include <stdbool.h>
#include "pico/stdlib.h"
#include "hardware/gpio.h"
#include "hardware/adc.h"

const uint RELAY_PIN = 15;
int main() {
    stdio_init_all();

    adc_init();
    gpio_init(RELAY_PIN);
    gpio_set_dir(RELAY_PIN, GPIO_OUT);
    // Make sure GPIO is high-impedance, no pullups etc
    adc_gpio_init(26);
    // Select ADC input 0 (GPIO26)
    adc_select_input(0);
    // 12-bit conversion, assume max value == ADC_VREF == 5V
    const float conversion_factor = 5.0f / (1 << 12);
    bool REL_OFF_FLAG;
    gpio_put(RELAY_PIN, 1);
    while (1) {
        // 12-bit conversion, assume max value == ADC_VREF == 5V
        uint16_t result = adc_read();
        float value_handle = result * conversion_factor;
        //printf("Value Handle: %f \n", value_handle);
        sleep_ms(5000);
        if (value_handle  < 1.7 && REL_OFF_FLAG == true) {
            gpio_put(RELAY_PIN, 1);
            //printf("On \n");
            REL_OFF_FLAG = false;
        }
        if (value_handle  >= 1.7 && REL_OFF_FLAG == false) {
            gpio_put(RELAY_PIN, 0);
            REL_OFF_FLAG = true;
            //printf("Off \n");
        }
        for (int i = 0; i < 120; i++) {
            sleep_ms(1000);
        }
    }
}

