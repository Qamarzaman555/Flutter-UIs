library local_pub;

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:math';
import 'dart:ui' as ui;

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
// import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:stacked/stacked.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:universal_html/html.dart' show window;

import 'buttons/action_button.dart';
import 'tables/datatable/components/paginator.dart';
import 'tables/datatable/components/table_header.dart';

// import 'package:vph_web_date_picker/vph_web_date_picker.dart';

part 'appbar/chi_appbar.dart';
part 'audiomanager/audio_manager.dart';
part 'bars/chi_animated_switch.dart';
part 'bars/chi_tabbar.dart';
part 'bars/chi_toggle_bar.dart';
part 'bottomsheets/drop_down_bottom_sheet.dart';
part 'bottomsheets/multi_selection_bottom_sheet.dart';
part 'buttons/button_loader.dart';
part 'buttons/chat_button.dart';
part 'buttons/chi_button.dart';
part 'buttons/chi_outline_button.dart';
part 'buttons/social_button.dart';
part 'buttons/toggle_button.dart';
part 'cards/chi_card.dart';
part 'cards/chi_shade_card.dart';
part 'cards/status_holder.dart';
part 'datetimepickers/chi_date_picker.dart';
part 'datetimepickers/chi_web_date_picker.dart';
part 'datetimepickers/daterange_picker.dart';
part 'datetimepickers/vph_date_picker.dart';
part 'dialogs/chi_dialogs.dart';
part 'drawer/chi_drawer.dart';
part 'imageholder/chi_image_holder.dart';
part 'inputfields/chi_address_field.dart';
part 'inputfields/chi_dropdown_field.dart';
part 'inputfields/chi_email_field.dart';
part 'inputfields/chi_float_field.dart';
part 'inputfields/chi_integer_field.dart';
part 'inputfields/chi_password_field.dart';
part 'inputfields/chi_text_field.dart';
part 'inputfields/countrypicker/chi_country_picker.dart';
part 'inputfields/countrypicker/country_json.dart';
part 'inputfields/countrypicker/country_model.dart';
part 'loaders/chi_progress_indicator.dart';
part 'loaders/circular_percentage_indicator.dart';
part 'mapfields/chi_google_map.dart';
part 'mapfields/chi_google_map_widget.dart';
part 'mapfields/directionpicker/chi_direction_picker.dart';
part 'mapfields/directionpicker/chi_direction_widget.dart';
part 'mapfields/locationpicker/chi_location_picker.dart';
part 'navbar/bottom_navbar.dart';
part 'norecord/no_record.dart';
part 'pdfviewer/chi_pdf_viewer.dart';
part 'responsive/chi_responsive.dart';
part 'router/chi_router.dart';
part 'selectionbuttons/chi_check_box.dart';
part 'selectionbuttons/chi_checkbox_tile.dart';
part 'selectionbuttons/chi_radio_button.dart';
part 'selectionbuttons/chi_radio_tile.dart';
part 'services/api_client.dart';
part 'services/api_response.dart';
part 'slider/chi_slider.dart';
part 'tables/datatable/chi_data_source.dart';
part 'tables/datatable/chi_data_table.dart';
part 'tables/datatable/service/table_vm.dart';
part 'utils/chi_styles.dart';
part 'utils/chi_theme_extension.dart';
part 'utils/extensions.dart';
part 'utils/utils.dart';
part 'videoplayer/chi_video_player.dart';
