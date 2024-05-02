/*
Copyright 2022 Joe Scotto

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include QMK_KEYBOARD_H

#include "oneshot.h"

#define LA_SYM MO(SYM)
#define LA_NAV MO(NAV)

enum layers {
    DEF,
    SYM,
    NAV,
    FUN,
    NUM,
};

enum keycodes {
    // Custom oneshot mod implementation with no timers.
    OS_SHFT = SAFE_RANGE,
    OS_CTRL,
    OS_ALT,
    OS_GUI,
    OS_RALT,
};

// Combos
const uint16_t PROGMEM z_combo[] = {KC_W, KC_M, COMBO_END};
const uint16_t PROGMEM q_combo[] = {KC_W, KC_G, COMBO_END};
const uint16_t PROGMEM q_combo2[] = {KC_M, KC_G, COMBO_END};
combo_t key_combos[] = {
    COMBO(z_combo, KC_Z),
    COMBO(q_combo, KC_Q),
    COMBO(q_combo2, KC_Q),
};

// Key overrides (custom shift keys)
const key_override_t dub_quote_override = ko_make_basic(MOD_MASK_SHIFT, KC_DQT,   S(KC_1));
const key_override_t hash_override =      ko_make_basic(MOD_MASK_SHIFT, KC_HASH,  S(KC_2));
const key_override_t dot_override =       ko_make_basic(MOD_MASK_SHIFT, KC_DOT,   KC_COLN);
const key_override_t quote_override =     ko_make_basic(MOD_MASK_SHIFT, KC_QUOTE, S(KC_SLASH));
const key_override_t comma_override =     ko_make_basic(MOD_MASK_SHIFT, KC_COMMA, KC_SEMICOLON);
const key_override_t slash_override =     ko_make_basic(MOD_MASK_SHIFT, KC_SLASH, S(KC_8));
const key_override_t dash_override =      ko_make_basic(MOD_MASK_SHIFT, KC_MINUS, S(KC_EQUAL));

// This globally defines all key overrides to be used
const key_override_t **key_overrides = (const key_override_t *[]){
    &dub_quote_override,
    &hash_override,
    &dot_override,
    &quote_override,
    &comma_override,
    &slash_override,
    &dash_override,
    NULL // Null terminate the array of overrides!
};

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

    [DEF] = LAYOUT_split_3x5_3(
    //------------------------------------------|------------------------------------------
        KC_X, KC_W, KC_M,         KC_G, KC_DQT,  KC_HASH, KC_DOT, KC_QUOT,      KC_J, KC_B,
        KC_S, KC_C, LSFT_T(KC_N), CTL_T(KC_T), KC_K,    KC_COMM, CTL_T(KC_A),   LSFT_T(KC_E), KC_I, KC_H,
        KC_V, KC_P, KC_L,         KC_D, KC_SLSH, KC_MINS, KC_U,   KC_O,         KC_Y, KC_F,

        QK_REP, KC_R, LA_SYM, LA_NAV, KC_SPC, KC_LCTL),

    [SYM] = LAYOUT_split_3x5_3(
    //---------------------------------------------------------------------------|--------------------------------------------
        KC_EXLM,       KC_AT,         KC_HASH,       KC_DLR,        KC_PERC,       KC_CIRC, KC_AMPR, KC_ASTR, KC_LPRN, KC_RPRN,
        OS_ALT, OS_GUI, OS_SHFT, OS_CTRL, OS_RALT, KC_TRNS, KC_UNDS, KC_EQL,  KC_LCBR, KC_RCBR,
        KC_GRV,        KC_BSLS,       KC_PIPE,       KC_TILD,       QK_REP,       KC_TRNS, KC_BSPC, KC_TRNS, KC_LBRC, KC_RBRC,

        TO(NUM), TO(NAV), KC_TRNS, KC_TRNS, KC_ENT, KC_TRNS),

    [NAV] = LAYOUT_split_3x5_3(
    //---------------------------------------------|--------------------------------------------------------------------------
        KC_ESC,  KC_HOME, KC_UP,   KC_END,  KC_PGUP, KC_TRNS,       KC_MPLY,       KC_MPRV,       KC_MNXT,       KC_PSCR,
        KC_TAB,  KC_LEFT, KC_DOWN, KC_RGHT, KC_PGDN, OS_RALT, OS_CTRL, OS_SHFT, OS_GUI, OS_ALT,
        KC_LSFT, KC_INS,  KC_DEL,  KC_BSPC, KC_CAPS, QK_BOOT,       KC_VOLD,       KC_VOLU,       KC_MUTE,       KC_APP,

        KC_LCTL, KC_ENT, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS),

    [FUN] = LAYOUT_split_3x5_3(
        KC_1,          KC_2,          KC_3,          KC_4,          KC_5,   KC_6,   KC_7,          KC_8,          KC_9,          KC_0,
        OS_ALT, OS_GUI, OS_SHFT, OS_CTRL, KC_F11, KC_F12, OS_CTRL, OS_SHFT, OS_GUI, OS_ALT,
        KC_F1,         KC_F2,         KC_F3,         KC_F4,         KC_F5,  KC_F6,  KC_F7,         KC_F8,         KC_F9,         KC_F10,

        KC_TRNS, KC_ENT, KC_TRNS, KC_TRNS, KC_ENT, KC_TRNS),

    [NUM] = LAYOUT_split_3x5_3(
        KC_F2, KC_7, KC_8, KC_9, KC_PMNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_EQL, KC_4, KC_5, KC_6, KC_PPLS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_PSLS, KC_1, KC_2, KC_3, KC_PAST, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS,
        KC_PDOT, KC_0, KC_TRNS, MO(NUM), KC_TRNS, KC_TRNS)

};

bool is_oneshot_cancel_key(uint16_t keycode) {
    switch (keycode) {
    case LA_SYM:
    case LA_NAV:
        return true;
    default:
        return false;
    }
}

bool is_oneshot_ignored_key(uint16_t keycode) {
    switch (keycode) {
    case LA_SYM:
    case LA_NAV:
    case KC_LSFT:
    case OS_SHFT:
    case OS_CTRL:
    case OS_ALT:
    case OS_GUI:
    case OS_RALT:
        return true;
    default:
        return false;
    }
}

oneshot_state os_shft_state = os_up_unqueued;
oneshot_state os_ctrl_state = os_up_unqueued;
oneshot_state os_alt_state = os_up_unqueued;
oneshot_state os_gui_state = os_up_unqueued;
oneshot_state os_ralt_state = os_up_unqueued;

bool process_record_user(uint16_t keycode, keyrecord_t *record) {
    update_oneshot(
        &os_shft_state, KC_LSFT, OS_SHFT,
        keycode, record
    );
    update_oneshot(
        &os_ctrl_state, KC_LCTL, OS_CTRL,
        keycode, record
    );
    update_oneshot(
        &os_alt_state, KC_LALT, OS_ALT,
        keycode, record
    );
    update_oneshot(
        &os_gui_state, KC_LGUI, OS_GUI,
        keycode, record
    );
    update_oneshot(
        &os_ralt_state, KC_RALT, OS_RALT,
        keycode, record
    );

    return true;
}

layer_state_t layer_state_set_user(layer_state_t state) {
    return update_tri_layer_state(state, SYM, NAV, FUN);
}
