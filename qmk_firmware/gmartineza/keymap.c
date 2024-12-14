#include QMK_KEYBOARD_H
#include "keymap_spanish_latin_america.h"
#include "features/custom_shift_keys.h"

const key_override_t quote_override = ko_make_basic(MOD_MASK_SHIFT,ES_QUOT,ES_DQUO);
const key_override_t comma_override = ko_make_basic(MOD_MASK_SHIFT,ES_COMM,ES_LABK);
const key_override_t dot_override = ko_make_basic(MOD_MASK_SHIFT,ES_DOT,ES_RABK);

const key_override_t *key_overrides[] = {
    &quote_override,
    &comma_override,
    &dot_override
};

// custom shift keys
// https://getreuer.info/posts/keyboards/custom-shift-keys/index.html#implementation
// step 1
const custom_shift_key_t custom_shift_keys[] = {
  {LALT_T(KC_LT) , KC_GT}, // Shift ; is : and it is an alt mod-tap
};
uint8_t NUM_CUSTOM_SHIFT_KEYS =
    sizeof(custom_shift_keys) / sizeof(custom_shift_key_t);

// step 2

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
  if (!process_custom_shift_keys(keycode, record)) { return false; }
    switch (keycode) {
        case LALT_T(KC_LT):
            if (record->tap.count && record->event.pressed) {
                tap_code16(KC_LT);
                return false;
            }
            return true;
        default:
            return true;
    }
}

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
    [0] = LAYOUT_split_3x5_3(
        ES_QUOT,         ES_COMM,      ES_DOT,       KC_P,           KC_Y,         KC_F,         KC_G,           KC_C,         KC_R,         KC_L,
        KC_A,            KC_O,         KC_E,         KC_U,           KC_I,         KC_D,         KC_H,           KC_T,         KC_N,         KC_S,
        LALT_T(KC_LT), LGUI_T(KC_Q), LSFT_T(KC_J), LCTL_T(KC_K),   LT(2,KC_X),   LT(2,KC_B),   RCTL_T(KC_M),   RSFT_T(KC_W), RGUI_T(KC_V), LALT_T(KC_Z),
        TO(3), KC_SPC, MO(1), MO(3), KC_ENT, KC_NO
    ),
    [1] = LAYOUT_split_3x5_3(
        ES_EXLM,         ES_AT,        ES_NUMB,      ES_DLR,         ES_PERC,      ES_CIRC,      ES_AMPR,        ES_ASTR,      ES_LPRN,      ES_RPRN,
        ES_GRV,          ES_TILD,      ES_PLUS,      ES_EQL,         ES_PIPE,      ES_UNDS,      ES_MINS,        ES_SLSH,      ES_LCBR,      ES_RCBR,
        KC_LALT,         KC_LGUI,      KC_LSFT,      KC_LCTL,        ES_BSLS,      KC_TRNS,      KC_BSPC,        ES_QUES,      ES_LBRC,      ES_RBRC,
        KC_TRNS, KC_TRNS, KC_TRNS, MO(4), KC_ENT, KC_TRNS
    ),
    [2] = LAYOUT_split_3x5_3(
        ES_ACUT,         KC_TRNS,      KC_TRNS,      KC_TRNS,        KC_TRNS,      KC_TRNS,      KC_TRNS,        KC_TRNS,      KC_TRNS,      ES_IQUE,
        KC_TRNS,         KC_TRNS,      KC_TRNS,      KC_TRNS,        KC_TRNS,      KC_TRNS,      KC_TRNS,        KC_TRNS,      ES_NTIL,      KC_TRNS,
        KC_LALT,         KC_LGUI,      KC_LSFT,      KC_LCTL,        KC_TRNS,      KC_TRNS,      KC_RCTL,        KC_RSFT,      KC_RGUI,      KC_LALT,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    ),
    [3] = LAYOUT_split_3x5_3(
        KC_ESC,          KC_HOME,      KC_UP,        KC_END,         KC_PGUP,      KC_INS,       KC_MPLY,        KC_VOLU,      KC_MUTE,      KC_PSCR,
        KC_TAB,          KC_LEFT,      KC_DOWN,      KC_RGHT,        KC_PGDN,      KC_TRNS,      KC_MPRV,        KC_VOLD,      KC_MNXT,      LCTL(ES_NTIL),
        KC_CAPS,         KC_TRNS,      KC_DEL,       KC_BSPC,        KC_TRNS,      KC_TRNS,      KC_RCTL,        KC_RSFT,      KC_RGUI,      KC_LALT,
        KC_TRNS, KC_ENT, MO(4), KC_TRNS, KC_SPC, KC_APP
    ),
    [4] = LAYOUT_split_3x5_3(
        KC_1,            KC_2,         KC_3,         KC_4,           KC_5,         KC_6,         KC_7,           KC_8,         KC_9,         KC_0,
        KC_F1,           KC_F2,        KC_F3,        KC_F4,          KC_F5,        KC_F6,        KC_F7,          KC_F8,        KC_F9,        KC_F10,
        KC_LALT,         KC_LGUI,      KC_LSFT,      LCTL_T(KC_BSPC),KC_F11,       KC_F12,       RCTL_T(KC_BSPC),KC_RSFT,      KC_RGUI,      KC_LALT,
        KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS
    )
};
