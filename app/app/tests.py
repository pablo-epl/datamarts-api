from django.test import TestCase

from app.utils import get_reverse_sequence
from app.utils import get_reverse_complement_sequence


class UtilsTests(TestCase):

    def test_get_reverse_sequence(self):
        """Tests that the sequence is returned reversed"""
        self.assertEqual(get_reverse_sequence("ATCG"), "GCTA")

    def test_get_reverse_complement_sequence(self):
        """Tests that the sequence is returned as
        the complementary reversed sequence"""
        self.assertEqual(get_reverse_complement_sequence("ATCG"), "CGAT")

    def test_get_transcription_sequence(self):
        """Tests that the sequence is returned as a transcribed sequence"""
        self.assertEqual(get_transcription_sequence("ATCG", "AUCG"))